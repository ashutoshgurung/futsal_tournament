// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_registration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MyRegistrationModel _$MyRegistrationModelFromJson(Map<String, dynamic> json) =>
    _MyRegistrationModel(
      id: json['id'] as String,
      tournamentName: json['tournamentName'] as String,
      teamName: json['teamName'] as String,
      location: json['location'] as String,
      tournamentDate: DateTime.parse(json['tournamentDate'] as String),
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      registrationStatus: json['registrationStatus'] as String,
      paymentStatus: json['paymentStatus'] as String,
      captainName: json['captainName'] as String,
      captainPhone: json['captainPhone'] as String,
      registrationFee: json['registrationFee'] as String,
      players: (json['players'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$MyRegistrationModelToJson(
  _MyRegistrationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'tournamentName': instance.tournamentName,
  'teamName': instance.teamName,
  'location': instance.location,
  'tournamentDate': instance.tournamentDate.toIso8601String(),
  'registeredAt': instance.registeredAt.toIso8601String(),
  'registrationStatus': instance.registrationStatus,
  'paymentStatus': instance.paymentStatus,
  'captainName': instance.captainName,
  'captainPhone': instance.captainPhone,
  'registrationFee': instance.registrationFee,
  'players': instance.players,
};
