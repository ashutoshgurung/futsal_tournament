import 'package:freezed_annotation/freezed_annotation.dart';
part 'my_registration_model.freezed.dart';
part 'my_registration_model.g.dart';

@freezed
abstract class MyRegistrationModel with _$MyRegistrationModel {
  const factory MyRegistrationModel({
    required String id,
    required String tournamentName,
    required String teamName,
    required String location,
    required DateTime tournamentDate,
    required DateTime registeredAt,
    required String registrationStatus,
    required String paymentStatus,
    required String captainName,
    required String captainPhone,
    required String registrationFee,
    required List<String> players,
  }) = _MyRegistrationModel;

  factory MyRegistrationModel.fromJson(Map<String, dynamic> json) =>
      _$MyRegistrationModelFromJson(json);
}
