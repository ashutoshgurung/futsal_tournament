import 'package:freezed_annotation/freezed_annotation.dart';

part 'organizer_register_state.freezed.dart';

enum RegisterStatus { initial, loading, success, failure }

@freezed
abstract class OrganizerRegisterState with _$OrganizerRegisterState {
  const factory OrganizerRegisterState({
    @Default(RegisterStatus.initial) RegisterStatus status,
    @Default(true) bool hidePassword,
    @Default(false) bool agreed,
    String? errorMessage,
  }) = _OrganizerRegisterState;
}
