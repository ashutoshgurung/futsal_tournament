import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/all_tournaments/all_tournaments_event.dart';
import 'package:football_app/bloc/all_tournaments/all_tournaments_state.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';

class AllTournamentsBloc
    extends Bloc<AllTournamentsEvent, AllTournamentsState> {
  final TournamentRepository repository;

  AllTournamentsBloc(this.repository) : super(const AllTournamentsState()) {
    on<LoadAllTournaments>(_onLoadAll);
  }

  Future<void> _onLoadAll(
    LoadAllTournaments event,
    Emitter<AllTournamentsState> emit,
  ) async {
    emit(
      state.copyWith(status: AllTournamentsStatus.loading, errorMessage: null),
    );
    try {
      // Switch to repository.getAllTournaments() if your backend has a separate route
      final list = await repository.getUpcomingTournaments();
      emit(
        state.copyWith(status: AllTournamentsStatus.success, tournaments: list),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: AllTournamentsStatus.failure,
          errorMessage: 'Failed to load tournaments',
        ),
      );
    }
  }
}
