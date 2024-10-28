import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/client_logo_upload_res.dart';
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
    on<GetAllUsersEvent>(onGetAllUsersEvent);
    on<UpdateUserProfilePictureEvent>(onUpdateUserProfilePicture);
  }

  onGetUserDetails(GetUserDetailsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getUserDetails(onErrorCallback: (String message, int errorCode) {
      if (errorCode == 401) {
        GoRouter.of(event.context).go(AppRoutes.intial);
      }
      log(" $message");
    });
    log("user profile: $result");
    if (result != null) {
      emit(state.copyWith(user: result));
    } else {
      // ignore: use_build_context_synchronously
      GoRouter.of(event.context).go(AppRoutes.intial);
    }
  }

  onAddUserEvent(AddUserEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.addUser(
      clientId: event.clientId,
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      userType: event.userType,
      image: event.image,
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
      image: event.image,
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
    if (result != null) {
      emit(state.copyWith(uploadLogoResponse: result));
    }
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

  onGetAllUsersEvent(GetAllUsersEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getAllUsers(
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
    if (result != null) {
      emit(state.copyWith(listOfUsers: result));
    }
  }

  onUpdateUserProfilePicture(UpdateUserProfilePictureEvent event, Emitter emit) {
    print("...................Before emit ${state.listOfUsers[event.index].image}");
    // Copy the existing list of users
    final updatedListOfUsers = List<User>.from(state.listOfUsers).toList();

    // Update the user at the specified index with a new profile picture
    final updatedUser = updatedListOfUsers[event.index].copyWith(image: event.image);

    // Replace the old user with the updated user in the list
    updatedListOfUsers[event.index] = updatedUser;
    print("...................updated image ${updatedListOfUsers[event.index].image}");
    // Emit the updated state with the new list of users
    emit(state.copyWith(listOfUsers: updatedListOfUsers));
    print("...................After emit ${state.listOfUsers[event.index].image}");
    event.onDone();
  }
}
