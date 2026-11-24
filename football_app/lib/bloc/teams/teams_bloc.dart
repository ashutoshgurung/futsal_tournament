import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/repository/teams/teams_repository.dart';
import 'teams_event.dart';
import 'teams_state.dart';


class TeamsBloc extends Bloc<TeamsEvent, TeamsState> {
  TeamsBloc(this._repository) : super(const TeamsState()) {
    on<TeamsStarted>((_, emit) => _load(emit));
    on<TeamsRefreshed>((_, emit) => _load(emit, silent: true));
    on<TeamsSearchChanged>(
      (event, emit) => emit(state.copyWith(query: event.query)),
    );
    on<TeamsTeamAdded>(_onTeamAdded);
    on<TeamsTeamDeleted>(_onTeamDeleted);
  }

  final TeamsRepository _repository;

  Future<void> _load(Emitter<TeamsState> emit, {bool silent = false}) async {
    if (!silent) emit(state.copyWith(status: TeamsStatus.loading));
    try {
      final teams = await _repository.getTeams();
      emit(state.copyWith(
        status: TeamsStatus.success,
        teams: teams,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TeamsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onTeamAdded(
    TeamsTeamAdded event,
    Emitter<TeamsState> emit,
  ) async {
    try {
      final added = await _repository.addTeam(event.team);
      emit(state.copyWith(teams: [...state.teams, added]));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onTeamDeleted(
    TeamsTeamDeleted event,
    Emitter<TeamsState> emit,
  ) async {
    final previous = state.teams;
    // Optimistic update, roll back on failure.
    emit(state.copyWith(
      teams: previous.where((t) => t.id != event.id).toList(),
    ));
    try {
      await _repository.deleteTeam(event.id);
    } catch (e) {
      emit(state.copyWith(teams: previous, errorMessage: e.toString()));
    }
  }
}