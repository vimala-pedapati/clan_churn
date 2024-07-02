import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiRepository apiRepository;
  UserBloc({required this.apiRepository}) : super(const UserState.initial()) {
    on<GetUserDetailsEvent>(_onGetUserDetails);
  }

  _onGetUserDetails(GetUserDetailsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getUserDetails(
        onErrorCallback: (String message, int errorCode) {
      if (errorCode == 401) {
        GoRouter.of(event.context).go(AppRoutes.intial);
      }
      log(" $message");
    });
    log("user profile: $result");
    if (result != null) {
      emit(state.copyWith(user: result));
    } else {}
  }
}
