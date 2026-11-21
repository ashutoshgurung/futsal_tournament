import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:football_app/model/organizer_tournament/organizer_tournament_model.dart';

part 'organizer_tournament_event.freezed.dart';

@freezed
sealed class OrganizerTournamentEvent with _$OrganizerTournamentEvent {
  const factory OrganizerTournamentEvent.created(OrganizerTournament tournament) =
      OrganizerTournamentCreated;

  const factory OrganizerTournamentEvent.deleted(OrganizerTournament tournament) =
      OrganizerTournamentDeleted;

  const factory OrganizerTournamentEvent.deleteUndone() = OrganizerTournamentDeleteUndone;

  const factory OrganizerTournamentEvent.filterChanged(
    OrganizerTournamentStatus? filter,
  ) = OrganizerTournamentFilterChanged;
}