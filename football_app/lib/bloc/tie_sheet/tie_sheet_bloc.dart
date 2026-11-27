import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/model/tie_sheet/tie_sheet_models.dart';
import 'package:football_app/repository/tie_sheet/tie_sheet_repository.dart';
import 'tie_sheet_event.dart';
import 'tie_sheet_state.dart';

export 'tie_sheet_event.dart';
export 'tie_sheet_state.dart';

class TieSheetBloc extends Bloc<TieSheetEvent, TieSheetState> {
  TieSheetBloc(this._repo) : super(const TieSheetState()) {
    on<TieSheetListRequested>(_onList);
    on<TieSheetDetailRequested>(_onDetail);
    on<TieSheetGenerateSubmitted>(_onGenerate);
    on<TieSheetManualSubmitted>(_onManual);
    on<TieSheetPairingsReplaced>(_onReplace);
    on<TieSheetMetaUpdated>(_onMeta);
    on<TieSheetDeleted>(_onDelete);
    on<TieSheetMessageConsumed>(
      (e, emit) => emit(state.copyWith(errorMessage: null, lastAction: TieSheetAction.none)),
    );
  }

  final TieSheetRepository _repo;

  Future<void> _onList(TieSheetListRequested e, Emitter<TieSheetState> emit) async {
    emit(state.copyWith(listStatus: TieSheetStatus.loading, errorMessage: null));
    try {
      final sheets = await _repo.list(e.tournamentId);
      emit(state.copyWith(listStatus: TieSheetStatus.success, sheets: sheets));
    } catch (err) {
      emit(state.copyWith(listStatus: TieSheetStatus.failure, errorMessage: _msg(err)));
    }
  }

  Future<void> _onDetail(TieSheetDetailRequested e, Emitter<TieSheetState> emit) async {
    emit(state.copyWith(detailStatus: TieSheetStatus.loading, errorMessage: null));
    try {
      final sheet = await _repo.get(e.id);
      emit(state.copyWith(detailStatus: TieSheetStatus.success, selected: sheet));
    } catch (err) {
      emit(state.copyWith(detailStatus: TieSheetStatus.failure, errorMessage: _msg(err)));
    }
  }

  Future<void> _onGenerate(TieSheetGenerateSubmitted e, Emitter<TieSheetState> emit) {
    return _submit(
      emit,
      action: TieSheetAction.generated,
      call: () => _repo.generate(
        tournamentId: e.tournamentId,
        name: e.name,
        seedingMethod: e.seedingMethod,
        seeds: e.seeds,
        thirdPlaceMatch: e.thirdPlaceMatch,
      ),
    );
  }

  Future<void> _onManual(TieSheetManualSubmitted e, Emitter<TieSheetState> emit) {
    return _submit(
      emit,
      action: TieSheetAction.created,
      call: () => _repo.createManual(
        tournamentId: e.tournamentId,
        name: e.name,
        pairings: e.pairings,
        thirdPlaceMatch: e.thirdPlaceMatch,
      ),
    );
  }

  Future<void> _onReplace(TieSheetPairingsReplaced e, Emitter<TieSheetState> emit) {
    return _submit(
      emit,
      action: TieSheetAction.rearranged,
      call: () => _repo.replacePairings(
        e.id,
        pairings: e.pairings,
        thirdPlaceMatch: e.thirdPlaceMatch,
      ),
    );
  }

  Future<void> _onMeta(TieSheetMetaUpdated e, Emitter<TieSheetState> emit) {
    return _submit(
      emit,
      action: TieSheetAction.updated,
      call: () => _repo.update(
        e.id,
        name: e.name,
        isPublished: e.isPublished,
        isLocked: e.isLocked,
      ),
    );
  }

  Future<void> _onDelete(TieSheetDeleted e, Emitter<TieSheetState> emit) async {
    emit(state.copyWith(submitStatus: TieSheetStatus.loading, errorMessage: null));
    try {
      await _repo.delete(e.id);
      emit(state.copyWith(
        submitStatus: TieSheetStatus.success,
        lastAction: TieSheetAction.deleted,
        sheets: state.sheets.where((s) => s.id != e.id).toList(),
        selected: state.selected?.id == e.id ? null : state.selected,
      ));
    } catch (err) {
      emit(state.copyWith(submitStatus: TieSheetStatus.failure, errorMessage: _msg(err)));
    }
  }

  /// Shared flow for every call that returns a full TieSheet.
  Future<void> _submit(
    Emitter<TieSheetState> emit, {
    required TieSheetAction action,
    required Future<TieSheet> Function() call,
  }) async {
    emit(state.copyWith(submitStatus: TieSheetStatus.loading, errorMessage: null));
    try {
      final sheet = await call();
      final exists = state.sheets.any((s) => s.id == sheet.id);
      emit(state.copyWith(
        submitStatus: TieSheetStatus.success,
        lastAction: action,
        selected: sheet,
        detailStatus: TieSheetStatus.success,
        sheets: exists
            ? state.sheets.map((s) => s.id == sheet.id ? sheet : s).toList()
            : [sheet, ...state.sheets],
      ));
    } catch (err) {
      emit(state.copyWith(submitStatus: TieSheetStatus.failure, errorMessage: _msg(err)));
    }
  }

  // Backend errors come as { message } with 400/404/409
  String _msg(Object err) {
    if (err is DioException) {
      final data = err.response?.data;
      if (data is Map && data['message'] is String) return data['message'] as String;
      return err.message ?? 'Network error';
    }
    return err.toString();
  }
}