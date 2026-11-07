// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) =>
    _OrganizationModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      plan: json['plan'] as String? ?? 'free',
      logoUrl: json['logoUrl'] as String?,
      contactEmail: json['contactEmail'] as String? ?? '',
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$OrganizationModelToJson(_OrganizationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'plan': instance.plan,
      'logoUrl': instance.logoUrl,
      'contactEmail': instance.contactEmail,
      'isActive': instance.isActive,
    };
