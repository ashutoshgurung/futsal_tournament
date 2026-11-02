// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TournamentModel _$TournamentModelFromJson(Map<String, dynamic> json) =>
    _TournamentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['venue'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      registeredTeams: (json['registeredTeams'] as num?)?.toInt() ?? 0,
      maxTeams: (json['maxTeams'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] == null
          ? TournamentStatus.upcoming
          : const TournamentStatusConverter().fromJson(
              json['status'] as String?,
            ),
    );

Map<String, dynamic> _$TournamentModelToJson(_TournamentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'venue': instance.location,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'registeredTeams': instance.registeredTeams,
      'maxTeams': instance.maxTeams,
      'imageUrl': instance.imageUrl,
      'status': const TournamentStatusConverter().toJson(instance.status),
    };
