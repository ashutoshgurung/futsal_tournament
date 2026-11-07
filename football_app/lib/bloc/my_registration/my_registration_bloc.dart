import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/bloc/my_registration/my_registration_event.dart';
import 'package:football_app/bloc/my_registration/my_registration_state.dart';

import '../../repository/my_registration/my_registration_repository.dart';

class MyRegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationRepository repository;

  MyRegistrationBloc(this.repository) : super(RegistrationInitial()) {
    on<LoadRegistrations>(_onLoadRegistrations);
  }

  Future<void> _onLoadRegistrations(
    LoadRegistrations event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading());

    try {
      final registrations = await repository.getMyRegistrations();

      emit(RegistrationLoaded(registrations));
    } catch (e) {
      emit(RegistrationError('Unable to load your registrations.'));
    }
  }
}
