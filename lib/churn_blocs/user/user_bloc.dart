import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiRepository apiRepository;
  UserBloc({required this.apiRepository}) : super(const UserState.initial()) {
    on<GetUserDetailsEvent>(onGetUserDetails);
    on<AddUserEvent>(onAddUserEvent);
    on<UpdateUserEvent>(onUpdateUserEvent);
    on<GetUserTypesEvent>(onGetUserTypesEvent);
    on<UploadUserProfileEvent>(onUploadUserProfileEvent);
    on<DeleteUserEvent>(onDeleteUserEvent);
  }

  onGetUserDetails(GetUserDetailsEvent event, Emitter<UserState> emit) async {
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

  onAddUserEvent(AddUserEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.addUser(
      clientId: event.clientId,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      userType: event.userType,
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
  }

  onUpdateUserEvent(UpdateUserEvent event, Emitter<UserState> emit) async {
    print("from bloc");
    final result = await apiRepository.updateUser(
      clientId: event.clientId,
      firstName: event.firstName,
      lastName: event.lastName,
      userId: event.userId,
      password: event.password,
      userType: event.userType,
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
  }

  onUploadUserProfileEvent(UploadUserProfileEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.uploadUserPic(
      filePickerResult: event.filePickerResult,
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
  }

  onGetUserTypesEvent(GetUserTypesEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getUserTypes(
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
    if (result != null) {
      emit(state.copyWith(userTypes: result));
    }
  }

  onDeleteUserEvent(DeleteUserEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.deleteUser(
      userId: event.userId,
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
  }
}
