import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_registration_event.freezed.dart';

@freezed
abstract class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent.loadRegistrations() = LoadRegistrations;
}