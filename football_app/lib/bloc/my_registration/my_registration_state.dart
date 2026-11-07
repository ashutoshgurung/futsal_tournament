import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:football_app/model/my_registration/my_registration_model.dart';

part 'my_registration_state.freezed.dart';

@freezed
abstract class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = RegistrationInitial;

  const factory RegistrationState.loading() = RegistrationLoading;

  const factory RegistrationState.loaded(
    List<MyRegistrationModel> registrations,
  ) = RegistrationLoaded;

  const factory RegistrationState.error(String message) = RegistrationError;
}