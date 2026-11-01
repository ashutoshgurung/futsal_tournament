import 'package:football_app/model/tournament/tournament_model.dart';
import 'package:football_app/repository/tournament/tournament_repository.dart';

class TournamentMockRepository implements TournamentRepository {
  @override
  Future<List<TournamentModel>> getUpcomingTournaments() async {
    await Future.delayed(const Duration(seconds: 1)); // fake network delay

    return [
      TournamentModel(
        id: '1',
        name: 'Jarkut Tournament 2026',
        location: 'Pokhara, Nepal',
        startDate: DateTime(2026, 11, 15),
        endDate: DateTime(2026, 11, 25),
        registeredTeams: 12,
        maxTeams: 16,
        imageUrl: 'assets/images/futsal1.jpg',
        status: TournamentStatus.open,
      ),
      TournamentModel(
        id: '2',
        name: 'Pokhara Futsal Cup 2026',
        location: 'Butwal, Nepal',
        startDate: DateTime(2026, 11, 28),
        endDate: DateTime(2026, 12, 5),
        registeredTeams: 5,
        maxTeams: 16,
        imageUrl: 'assets/images/futsal2.jpg',
        status: TournamentStatus.upcoming,
      ),
      TournamentModel(
        id: '3',
        name: 'College Futsal Tournament',
        location: 'Kathmandu, Nepal',
        startDate: DateTime(2026, 12, 10),
        endDate: DateTime(2026, 12, 18),
        registeredTeams: 0,
        maxTeams: 20,
        imageUrl: 'assets/images/futsal3.jpg',
        status: TournamentStatus.registrationSoon,
      ),
      TournamentModel(
        id: '4',
        name: 'Lakeside Futsal Challenge',
        location: 'Pokhara, Nepal',
        startDate: DateTime(2026, 12, 20),
        endDate: DateTime(2026, 12, 28),
        registeredTeams: 0,
        maxTeams: 12,
        imageUrl: 'assets/images/futsal4.jpg',
        status: TournamentStatus.registrationSoon,
      ),
    ];
  }
}
