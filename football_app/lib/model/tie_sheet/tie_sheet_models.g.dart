// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tie_sheet_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Team _$TeamFromJson(Map<String, dynamic> json) => _Team(
  id: json['id'] as String,
  name: json['name'] as String,
  shortName: json['shortName'] as String?,
  logoUrl: json['logoUrl'] as String?,
);

Map<String, dynamic> _$TeamToJson(_Team instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'shortName': instance.shortName,
  'logoUrl': instance.logoUrl,
};

_BracketMatch _$BracketMatchFromJson(Map<String, dynamic> json) =>
    _BracketMatch(
      id: json['id'] as String,
      round: (json['round'] as num).toInt(),
      roundName: json['roundName'] as String?,
      matchNumber: (json['matchNumber'] as num).toInt(),
      bracketPosition: (json['bracketPosition'] as num).toInt(),
      team1Id: json['team1Id'] as String?,
      team2Id: json['team2Id'] as String?,
      winnerId: json['winnerId'] as String?,
      team1: json['team1'] == null
          ? null
          : Team.fromJson(json['team1'] as Map<String, dynamic>),
      team2: json['team2'] == null
          ? null
          : Team.fromJson(json['team2'] as Map<String, dynamic>),
      winner: json['winner'] == null
          ? null
          : Team.fromJson(json['winner'] as Map<String, dynamic>),
      isBye: json['isBye'] as bool? ?? false,
      status: json['status'] as String? ?? 'scheduled',
      nextMatchId: json['nextMatchId'] as String?,
      nextMatchSlot: (json['nextMatchSlot'] as num?)?.toInt(),
      loserNextMatchId: json['loserNextMatchId'] as String?,
      loserNextSlot: (json['loserNextSlot'] as num?)?.toInt(),
      team1Score: (json['team1Score'] as num?)?.toInt(),
      team2Score: (json['team2Score'] as num?)?.toInt(),
      penaltyTeam1: (json['penaltyTeam1'] as num?)?.toInt(),
      penaltyTeam2: (json['penaltyTeam2'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BracketMatchToJson(_BracketMatch instance) =>
    <String, dynamic>{
      'id': instance.id,
      'round': instance.round,
      'roundName': instance.roundName,
      'matchNumber': instance.matchNumber,
      'bracketPosition': instance.bracketPosition,
      'team1Id': instance.team1Id,
      'team2Id': instance.team2Id,
      'winnerId': instance.winnerId,
      'team1': instance.team1,
      'team2': instance.team2,
      'winner': instance.winner,
      'isBye': instance.isBye,
      'status': instance.status,
      'nextMatchId': instance.nextMatchId,
      'nextMatchSlot': instance.nextMatchSlot,
      'loserNextMatchId': instance.loserNextMatchId,
      'loserNextSlot': instance.loserNextSlot,
      'team1Score': instance.team1Score,
      'team2Score': instance.team2Score,
      'penaltyTeam1': instance.penaltyTeam1,
      'penaltyTeam2': instance.penaltyTeam2,
    };

_BracketRound _$BracketRoundFromJson(Map<String, dynamic> json) =>
    _BracketRound(
      round: (json['round'] as num).toInt(),
      name: json['name'] as String,
      matches:
          (json['matches'] as List<dynamic>?)
              ?.map((e) => BracketMatch.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BracketRoundToJson(_BracketRound instance) =>
    <String, dynamic>{
      'round': instance.round,
      'name': instance.name,
      'matches': instance.matches,
    };

_TieSheetEntry _$TieSheetEntryFromJson(Map<String, dynamic> json) =>
    _TieSheetEntry(
      teamId: json['teamId'] as String,
      slot: (json['slot'] as num).toInt(),
      seed: (json['seed'] as num?)?.toInt(),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TieSheetEntryToJson(_TieSheetEntry instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'slot': instance.slot,
      'seed': instance.seed,
      'team': instance.team,
    };

_TieSheet _$TieSheetFromJson(Map<String, dynamic> json) => _TieSheet(
  id: json['id'] as String,
  tournamentId: json['tournamentId'] as String,
  name: json['name'] as String,
  type: json['type'] as String? ?? 'single_elimination',
  seedingMethod: json['seedingMethod'] as String? ?? 'random',
  bracketSize: (json['bracketSize'] as num).toInt(),
  totalRounds: (json['totalRounds'] as num).toInt(),
  thirdPlaceMatch: json['thirdPlaceMatch'] as bool? ?? false,
  isPublished: json['isPublished'] as bool? ?? false,
  isLocked: json['isLocked'] as bool? ?? false,
  generatedAt: json['generatedAt'] == null
      ? null
      : DateTime.parse(json['generatedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  entries:
      (json['entries'] as List<dynamic>?)
          ?.map((e) => TieSheetEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  rounds:
      (json['rounds'] as List<dynamic>?)
          ?.map((e) => BracketRound.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$TieSheetToJson(_TieSheet instance) => <String, dynamic>{
  'id': instance.id,
  'tournamentId': instance.tournamentId,
  'name': instance.name,
  'type': instance.type,
  'seedingMethod': instance.seedingMethod,
  'bracketSize': instance.bracketSize,
  'totalRounds': instance.totalRounds,
  'thirdPlaceMatch': instance.thirdPlaceMatch,
  'isPublished': instance.isPublished,
  'isLocked': instance.isLocked,
  'generatedAt': instance.generatedAt?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
  'entries': instance.entries,
  'rounds': instance.rounds,
};

_Pairing _$PairingFromJson(Map<String, dynamic> json) => _Pairing(
  team1Id: json['team1Id'] as String?,
  team2Id: json['team2Id'] as String?,
);

Map<String, dynamic> _$PairingToJson(_Pairing instance) => <String, dynamic>{
  'team1Id': instance.team1Id,
  'team2Id': instance.team2Id,
};
