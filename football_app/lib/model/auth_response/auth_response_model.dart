import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:football_app/model/user/user_model.dart';
import 'package:football_app/model/organization/organization_model.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

@freezed
abstract class AuthResponseModel with _$AuthResponseModel{
  factory AuthResponseModel({
    @Default('') String token,
    UserModel? user,
    OrganizationModel? organization,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}