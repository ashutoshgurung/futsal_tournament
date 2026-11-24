import 'package:football_app/model/team/team.dart';

abstract class TeamsRepository {
  Future<List<Team>> getTeams();
  Future<Team> addTeam(Team team);
  Future<void> deleteTeam(String id);
}

/// Replace with your API / Firebase / Supabase implementation.
class MockTeamsRepository implements TeamsRepository {
  final List<Team> _teams = [
    const Team(id: '1', name: 'Lakeside FC', city: 'Pokhara', players: 18),
    const Team(id: '2', name: 'Annapurna United', city: 'Pokhara', players: 20),
    const Team(id: '3', name: 'Fewa Warriors', city: 'Lekhnath', players: 16),
    const Team(id: '4', name: 'Machhapuchhre SC', city: 'Kaski', players: 22),
    const Team(id: '5', name: 'Gandaki Strikers', city: 'Syangja', players: 19),
  ];

  @override
  Future<List<Team>> getTeams() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.unmodifiable(_teams);
  }

  @override
  Future<Team> addTeam(Team team) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _teams.add(team);
    return team;
  }

  @override
  Future<void> deleteTeam(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _teams.removeWhere((t) => t.id == id);
  }
}
