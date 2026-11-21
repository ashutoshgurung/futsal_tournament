import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/organizer_tournament/organizer_tournament_event.dart';
import 'package:football_app/bloc/organizer_tournament/organizer_tournament_state.dart';

class TournamentBloc extends Bloc<OrganizerTournamentEvent, OrganizerTournamentState> {
  // TODO: inject a repository here to persist tournaments.
  TournamentBloc() : super(const OrganizerTournamentState()) {
    on<OrganizerTournamentCreated>(_onCreated);
    on<OrganizerTournamentDeleted>(_onDeleted);
    on<OrganizerTournamentDeleteUndone>(_onDeleteUndone);
    on<OrganizerTournamentFilterChanged>(_onFilterChanged);
  }

  void _onCreated(OrganizerTournamentCreated event, Emitter<OrganizerTournamentState> emit) {
    emit(state.copyWith(
      tournaments: [event.tournament, ...state.tournaments],
      lastDeleted: null,
      lastDeletedIndex: 0,
    ));
  }

  void _onDeleted(OrganizerTournamentDeleted event, Emitter<OrganizerTournamentState> emit) {
    final index =
        state.tournaments.indexWhere((t) => t.id == event.tournament.id);
    if (index == -1) return;

    final updated = [...state.tournaments]..removeAt(index);

    emit(state.copyWith(
      tournaments: updated,
      lastDeleted: event.tournament,
      lastDeletedIndex: index,
    ));
  }

  void _onDeleteUndone(
    OrganizerTournamentDeleteUndone event,
    Emitter<OrganizerTournamentState> emit,
  ) {
    final deleted = state.lastDeleted;
    if (deleted == null) return;

    final updated = [...state.tournaments];
    final index = state.lastDeletedIndex.clamp(0, updated.length);
    updated.insert(index, deleted);

    emit(state.copyWith(
      tournaments: updated,
      lastDeleted: null,
      lastDeletedIndex: 0,
    ));
  }

  void _onFilterChanged(
    OrganizerTournamentFilterChanged event,
    Emitter<OrganizerTournamentState> emit,
  ) {
    emit(state.copyWith(filter: event.filter));
  }
}