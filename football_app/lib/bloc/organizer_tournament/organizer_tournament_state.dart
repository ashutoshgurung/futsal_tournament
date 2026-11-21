import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:football_app/model/organizer_tournament/organizer_tournament_model.dart';
part 'organizer_tournament_state.freezed.dart';

@freezed
abstract class OrganizerTournamentState with _$OrganizerTournamentState {
  const OrganizerTournamentState._();

  const factory OrganizerTournamentState({
    @Default([]) List<OrganizerTournament> tournaments,
    OrganizerTournamentStatus? filter, // null = All
    // Used by the UI to show the "deleted / Undo" snackbar.
    OrganizerTournament? lastDeleted,
    @Default(0) int lastDeletedIndex,
  }) = _OrganizerTournamentState;

  List<OrganizerTournament> get visible => filter == null
      ? tournaments
      : tournaments.where((t) => t.status == filter).toList();
}
