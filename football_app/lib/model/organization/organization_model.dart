import 'package:freezed_annotation/freezed_annotation.dart';
part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
abstract class OrganizationModel with _$OrganizationModel {
  factory OrganizationModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String slug,
    @Default('free') String plan,
    String? logoUrl,
    @Default('') String contactEmail,
    @Default(true) bool isActive,
  }) = _OrganizationModel;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);
}