import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_tournaments_event.freezed.dart';

@freezed
sealed class AllTournamentsEvent with _$AllTournamentsEvent {
  const factory AllTournamentsEvent.loadAll() = LoadAllTournaments;
}