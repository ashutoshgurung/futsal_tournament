import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_event.freezed.dart';

@freezed
sealed class TournamentEvent with _$TournamentEvent {
  const factory TournamentEvent.loadUpcoming() = LoadUpcomingTournaments;
}
