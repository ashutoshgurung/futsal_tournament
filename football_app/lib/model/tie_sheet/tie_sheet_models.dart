import 'package:freezed_annotation/freezed_annotation.dart';

part 'tie_sheet_models.freezed.dart';
part 'tie_sheet_models.g.dart';

@freezed
abstract class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    String? shortName,
    String? logoUrl,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

@freezed
abstract class BracketMatch with _$BracketMatch {
  const factory BracketMatch({
    required String id,
    required int round,
    String? roundName,
    required int matchNumber,
    required int bracketPosition,
    String? team1Id,
    String? team2Id,
    String? winnerId,
    Team? team1,
    Team? team2,
    Team? winner,
    @Default(false) bool isBye,
    @Default('scheduled') String status,
    String? nextMatchId,
    int? nextMatchSlot,
    String? loserNextMatchId,
    int? loserNextSlot,
    int? team1Score,
    int? team2Score,
    int? penaltyTeam1,
    int? penaltyTeam2,
  }) = _BracketMatch;

  factory BracketMatch.fromJson(Map<String, dynamic> json) => _$BracketMatchFromJson(json);
}

@freezed
abstract class BracketRound with _$BracketRound {
  const factory BracketRound({
    required int round,
    required String name,
    @Default([]) List<BracketMatch> matches,
  }) = _BracketRound;

  factory BracketRound.fromJson(Map<String, dynamic> json) => _$BracketRoundFromJson(json);
}

@freezed
abstract class TieSheetEntry with _$TieSheetEntry {
  const factory TieSheetEntry({
    required String teamId,
    required int slot,
    int? seed,
    Team? team,
  }) = _TieSheetEntry;

  factory TieSheetEntry.fromJson(Map<String, dynamic> json) => _$TieSheetEntryFromJson(json);
}

@freezed
abstract class TieSheet with _$TieSheet {
  const factory TieSheet({
    required String id,
    required String tournamentId,
    required String name,
    @Default('single_elimination') String type,
    @Default('random') String seedingMethod,
    required int bracketSize,
    required int totalRounds,
    @Default(false) bool thirdPlaceMatch,
    @Default(false) bool isPublished,
    @Default(false) bool isLocked,
    DateTime? generatedAt,
    DateTime? createdAt,
    // Present on detail endpoint only
    @Default([]) List<TieSheetEntry> entries,
    @Default([]) List<BracketRound> rounds,
  }) = _TieSheet;

  factory TieSheet.fromJson(Map<String, dynamic> json) => _$TieSheetFromJson(json);
}

/// Used by the manual / replace-pairings endpoints.
/// Omit [team2Id] for a bye.
@freezed
abstract class Pairing with _$Pairing {
  const factory Pairing({
    String? team1Id,
    String? team2Id,
  }) = _Pairing;

  factory Pairing.fromJson(Map<String, dynamic> json) => _$PairingFromJson(json);
}