// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInBlocEvent, SignInBlocState> {
  AuthRepo authRepository;
  SignInBloc({required this.authRepository}) : super(const SignInBlocState.initial()) {
    on<SignInEvent>(_onSignInEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }
  _onSignInEvent(SignInEvent event, Emitter<SignInBlocState> emit) async {
    emit(state.copyWith(isLoggingIn: true));
    final result = await authRepository.signInApiCall(email: event.email, password: event.password);
    log("........sign in output $result ${result == AuthStatus.authenticated}");
    if (result == AuthStatus.authenticated) {
      emit(state.copyWith(status: AuthStatus.authenticated));
      GoRouter.of(event.context).go(AppRoutes.client);
    } else if (result == AuthStatus.unauthenticated) {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      signInFail(context: event.context, message1: "Authentication Failed", message2: "Please check your credentials");
    } else {
      emit(state.copyWith(status: AuthStatus.unauthenticated));
      signInFail(context: event.context);
    }
    emit(state.copyWith(isLoggingIn: false));
  }

  _onSignOutEvent(SignOutEvent event, Emitter<SignInBlocState> emit) {
    authRepository.clearTokens().then(
      (value) {
        log("removed both access token and refresh token $value");
        if (value) {
          GoRouter.of(event.context).go(AppRoutes.intial);
        } else {
          signOutFail(context: event.context);
        }
      },
    );
  }
}

Future<void> signInFail({required BuildContext context, String message1 = "unable to login", String message2 = "Something went wrong or Email or password not correct"}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!

    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(message1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(08),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message2),
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

Future<void> signOutFail({required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Can't logout"),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Something went wrong, try again later'),
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
