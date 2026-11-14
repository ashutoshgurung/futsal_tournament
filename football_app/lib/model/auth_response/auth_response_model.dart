import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_model.freezed.dart';
part 'auth_response_model.g.dart';

/// Maps the backend auth response:
/// { success, token, user: {...}, organization: {...}, isNewUser? }
/// `user` / `organization` are kept as maps because their exact fields come from the
/// backend's dto.user / dto.org. Replace them with typed models whenever you want.
@freezed
abstract class AuthResponseModel with _$AuthResponseModel {
  const factory AuthResponseModel({
    @Default(true) bool success,
    required String token,
    Map<String, dynamic>? user,
    Map<String, dynamic>? organization,
    @Default(false) bool isNewUser,
  }) = _AuthResponseModel;

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);
}