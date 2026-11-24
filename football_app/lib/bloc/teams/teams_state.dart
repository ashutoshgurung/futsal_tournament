import 'package:football_app/model/team/team.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'teams_state.freezed.dart';

enum TeamsStatus { initial, loading, success, failure }

@freezed
abstract class TeamsState with _$TeamsState {
  const TeamsState._();

  const factory TeamsState({
    @Default(TeamsStatus.initial) TeamsStatus status,
    @Default([]) List<Team> teams,
    @Default('') String query,
    String? errorMessage,
  }) = _TeamsState;

  /// Derived, so the filter never goes out of sync with `teams` or `query`.
  List<Team> get visibleTeams {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return teams;
    return teams
        .where((t) =>
            t.name.toLowerCase().contains(q) ||
            t.city.toLowerCase().contains(q))
        .toList();
  }
}