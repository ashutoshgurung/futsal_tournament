import 'package:freezed_annotation/freezed_annotation.dart';

part 'organizer_register_event.freezed.dart';

@freezed
sealed class OrganizerRegisterEvent with _$OrganizerRegisterEvent {
  const factory OrganizerRegisterEvent.submitted({
    required String organizationName,
    required String contactEmail,
    required String logoUrl,
    required String userName,
    required String email,
    required String password,
  }) = OrganizerRegisterSubmitted;

  const factory OrganizerRegisterEvent.passwordVisibilityToggled() =
      OrganizerPasswordVisibilityToggled;

  const factory OrganizerRegisterEvent.termsChanged(bool agreed) =
      OrganizerTermsChanged;
}
