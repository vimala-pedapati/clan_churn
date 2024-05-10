// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInBlocEvent, SignInBlocState> {
  AuthRepository authRepository;
  SignInBloc({required this.authRepository})
      : super(const SignInBlocState.initial()) {
    on<SignInEvent>(_onSignInEvent);
  }
  _onSignInEvent(SignInEvent event, Emitter<SignInBlocState> emit) async {
    final result = await authRepository.signInApiCall(
        email: event.email, password: event.password);
    log("........sign in output $result ${result == AuthenticationStatus.authenticated}");
    if (result == AuthenticationStatus.authenticated) {
      emit(state.copyWith(status: AuthenticationStatus.authenticated));
      GoRouter.of(event.context).go(AppRoutes.home);
      // event.context.pushNamed("/home");
    } else {
      emit(state.copyWith(status: AuthenticationStatus.unauthenticated));
      showAlertDialog(context: event.context);
      // if (await authRepository.getAuthSession() != null) {
      //   log("access token from local storage: ${await authRepository.getAuthSession()}");
      //   emit(state.copyWith(status: AuthenticationStatus.authenticated));
      // } else {
      // }
    }
  }
}

Future<void> showAlertDialog({required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Authentication Failed'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Something went wrong, try again later '),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
