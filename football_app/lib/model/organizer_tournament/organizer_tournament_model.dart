import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:football_app/utils/format_date/format_date_screen.dart';

part 'organizer_tournament_model.freezed.dart';

enum OrganizerTournamentStatus { ongoing, upcoming, completed }

@freezed
abstract class OrganizerTournament with _$OrganizerTournament {
  const OrganizerTournament._();

  const factory OrganizerTournament({
    required String id,
    required String name,
    required String location,
    required DateTime startDate,
    required DateTime endDate,
    required int teams,
  }) = _OrganizerTournament;

  String get dates => '${formatDate(startDate)} - ${formatDate(endDate)}';

  OrganizerTournamentStatus get status {
    final n = DateTime.now();
    final today = DateTime(n.year, n.month, n.day);
    if (today.isBefore(startDate)) return OrganizerTournamentStatus.upcoming;
    if (today.isAfter(endDate)) return OrganizerTournamentStatus.completed;
    return OrganizerTournamentStatus.ongoing;
  }
}