import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';

import 'tournament_event.dart';
import 'tournament_state.dart';

class TournamentBloc extends Bloc<TournamentEvent, TournamentState> {
  final TournamentRepository repository;

  TournamentBloc(this.repository) : super(const TournamentState()) {
    on<LoadUpcomingTournaments>(_onLoadUpcoming);
  }

  Future<void> _onLoadUpcoming(
    LoadUpcomingTournaments event,
    Emitter<TournamentState> emit,
  ) async {
    emit(state.copyWith(status: TournamentStatusState.loading, error: null));
    try {
      final data = await repository.getUpcomingTournaments();
      emit(state.copyWith(
        status: TournamentStatusState.success,
        tournaments: data,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: TournamentStatusState.failure,
        error: e.toString(),
      ));
    }
  }
}