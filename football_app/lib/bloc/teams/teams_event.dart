import 'package:football_app/model/team/team.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'teams_event.freezed.dart';

@freezed
sealed class TeamsEvent with _$TeamsEvent {
  const factory TeamsEvent.started() = TeamsStarted;
  const factory TeamsEvent.refreshed() = TeamsRefreshed;
  const factory TeamsEvent.searchChanged(String query) = TeamsSearchChanged;
  const factory TeamsEvent.teamAdded(Team team) = TeamsTeamAdded;
  const factory TeamsEvent.teamDeleted(String id) = TeamsTeamDeleted;
}