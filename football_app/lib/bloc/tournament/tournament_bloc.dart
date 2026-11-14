import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/data/exceptions/app_exceptions.dart';
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
      emit(
        state.copyWith(
          status: TournamentStatusState.success,
          tournaments: data,
        ),
      );
    } on AppExceptions catch (e) {
      emit(
        state.copyWith(
          status: TournamentStatusState.failure,
          error: e.userMessage,
        ),
      );
    } catch (e) {
      // Shows parsing bugs (e.g. a wrong field type in fromJson) in the debug console
      debugPrint('Tournament load error: $e');
      emit(
        state.copyWith(
          status: TournamentStatusState.failure,
          error: 'Something went wrong while loading tournaments',
        ),
      );
    }
  }
}
