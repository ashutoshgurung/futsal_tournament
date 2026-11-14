// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponseModel _$AuthResponseModelFromJson(Map<String, dynamic> json) =>
    _AuthResponseModel(
      success: json['success'] as bool? ?? true,
      token: json['token'] as String,
      user: json['user'] as Map<String, dynamic>?,
      organization: json['organization'] as Map<String, dynamic>?,
      isNewUser: json['isNewUser'] as bool? ?? false,
    );

Map<String, dynamic> _$AuthResponseModelToJson(_AuthResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'token': instance.token,
      'user': instance.user,
      'organization': instance.organization,
      'isNewUser': instance.isNewUser,
    };
