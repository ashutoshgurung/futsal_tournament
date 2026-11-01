import 'package:football_app/model/tournament/tournament_model.dart';

abstract class TournamentRepository {
  Future<List<TournamentModel>> getUpcomingTournaments();
}
