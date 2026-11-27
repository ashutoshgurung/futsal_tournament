import 'package:football_app/model/tie_sheet/tie_sheet_models.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:football_app/model/tie_sheet/tie_sheet_models.dart';

part 'tie_sheet_state.freezed.dart';

enum TieSheetStatus { initial, loading, success, failure }

/// What the last write action was, so the UI can react (navigate, snackbar).
enum TieSheetAction { none, generated, created, rearranged, updated, deleted }

@freezed
abstract class TieSheetState with _$TieSheetState {
  const TieSheetState._();

  const factory TieSheetState({
    @Default(TieSheetStatus.initial) TieSheetStatus listStatus,
    @Default(TieSheetStatus.initial) TieSheetStatus detailStatus,
    @Default(TieSheetStatus.initial) TieSheetStatus submitStatus,
    @Default([]) List<TieSheet> sheets,
    TieSheet? selected,
    @Default(TieSheetAction.none) TieSheetAction lastAction,
    String? errorMessage,
  }) = _TieSheetState;

  bool get isListLoading => listStatus == TieSheetStatus.loading;
  bool get isDetailLoading => detailStatus == TieSheetStatus.loading;
  bool get isSubmitting => submitStatus == TieSheetStatus.loading;
  bool get canEditDraw =>
      selected != null &&
      !selected!.isLocked &&
      selected!.rounds
          .expand((r) => r.matches)
          .every((m) => m.isBye || m.status == 'scheduled');
}