import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInBlocEvent, SignInBlocState> {
  AuthRepository authRepository;
  SignInBloc({required this.authRepository})
      : super(const SignInBlocState.initial()) {
    on<SignInEvent>(_onSignInEvent);
  }
  _onSignInEvent(SignInEvent event, Emitter<SignInBlocState> emit) async {
    log(".................vimala");
    if (await authRepository.getAuthSession() != null) {
      log(".................1 ${await authRepository.getAuthSession()}");
      log(".................Before ${state.props}");
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
      log(".................After ${state.props}");
    } else {
      final result = await authRepository.signInApiCall();
      if (result == AuthenticationStatus.authenticated) {
        emit(state.copyWith(status: AuthenticationStatus.authenticated));
        log(".......true");
      } else {
        emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
        log(".......false");
      }
    }
  }
}
