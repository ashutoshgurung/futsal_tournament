// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TournamentModel _$TournamentModelFromJson(Map<String, dynamic> json) =>
    _TournamentModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      registeredTeams: (json['registeredTeams'] as num?)?.toInt() ?? 0,
      maxTeams: (json['maxTeams'] as num?)?.toInt() ?? 0,
      imageUrl: json['image'] as String? ?? '',
      status:
          $enumDecodeNullable(
            _$TournamentStatusEnumMap,
            json['status'],
            unknownValue: TournamentStatus.upcoming,
          ) ??
          TournamentStatus.upcoming,
    );

Map<String, dynamic> _$TournamentModelToJson(_TournamentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'registeredTeams': instance.registeredTeams,
      'maxTeams': instance.maxTeams,
      'image': instance.imageUrl,
      'status': _$TournamentStatusEnumMap[instance.status]!,
    };

const _$TournamentStatusEnumMap = {
  TournamentStatus.open: 'open',
  TournamentStatus.upcoming: 'upcoming',
  TournamentStatus.registrationSoon: 'registrationSoon',
};
