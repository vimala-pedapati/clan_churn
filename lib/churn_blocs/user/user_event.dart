part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends UserEvent {
  final BuildContext context;
  const GetUserDetailsEvent({required this.context});
}

class AddUserEvent extends UserEvent {
  final String clientId;
  final String firstName;
  final String? lastName;
  final String email;
  final String password;
  final String userType;
  final String? image;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const AddUserEvent(
      {required this.clientId,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.userType,
      required this.image,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class UpdateUserEvent extends UserEvent {
  final String? clientId;
  final String firstName;
  final String? lastName;
  final String userId;
  final String? password;
  final String userType;
  final String? image;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const UpdateUserEvent(
      {required this.clientId,
      required this.firstName,
      required this.lastName,
      required this.userId,
      required this.password,
      required this.userType,
      required this.image,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class UploadUserProfileEvent extends UserEvent {
  final FilePickerResult filePickerResult;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const UploadUserProfileEvent(
      {required this.filePickerResult,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class GetUserTypesEvent extends UserEvent {
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const GetUserTypesEvent(
      {required this.onErrorCallback, required this.onSuccessCallback});
}

class DeleteUserEvent extends UserEvent {
  final String userId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const DeleteUserEvent(
      {required this.userId,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class GetAllUsersEvent extends UserEvent {
  final String clientId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const GetAllUsersEvent({
    required this.clientId,
    required this.onErrorCallback,
    required this.onSuccessCallback,
  });
}


 