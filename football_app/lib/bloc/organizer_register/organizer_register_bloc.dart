import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/data/exceptions/app_exceptions.dart';
import 'package:football_app/repository/organizer/organizer_repository.dart';
import 'organizer_register_event.dart';
import 'organizer_register_state.dart';

class OrganizerRegisterBloc
    extends Bloc<OrganizerRegisterEvent, OrganizerRegisterState> {
  final OrganizerRepository _repository;

  OrganizerRegisterBloc(this._repository)
    : super(const OrganizerRegisterState()) {
    on<OrganizerRegisterSubmitted>(_onSubmitted);
    on<OrganizerPasswordVisibilityToggled>(
      (event, emit) => emit(state.copyWith(hidePassword: !state.hidePassword)),
    );
    on<OrganizerTermsChanged>(
      (event, emit) => emit(state.copyWith(agreed: event.agreed)),
    );
  }

  Future<void> _onSubmitted(
    OrganizerRegisterSubmitted event,
    Emitter<OrganizerRegisterState> emit,
  ) async {
    emit(state.copyWith(status: RegisterStatus.loading, errorMessage: null));

    try {
      await _repository.register(
        organizationName: event.organizationName,
        contactEmail: event.contactEmail,
        logoUrl: event.logoUrl,
        userName: event.userName,
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: RegisterStatus.success));
    } on AppExceptions catch (e) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: e.userMessage,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: RegisterStatus.failure,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }
}
