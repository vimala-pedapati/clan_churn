part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState.initial()
      : this(user: null, userTypes: const [], listOfUsers: const [], uploadLogoResponse: null);
  final User? user;
  final List<String> userTypes;
  final List<User> listOfUsers;
  final UploadLogoResponse? uploadLogoResponse;

  const UserState(
      {required this.user, required this.userTypes, required this.listOfUsers, required this.uploadLogoResponse});

  UserState copyWith(
      {User? user, List<String>? userTypes, List<User>? listOfUsers, UploadLogoResponse? uploadLogoResponse}) {
    return UserState(
        user: user ?? this.user,
        userTypes: userTypes ?? this.userTypes,
        listOfUsers: listOfUsers ?? this.listOfUsers,
        uploadLogoResponse:  uploadLogoResponse ?? this.uploadLogoResponse);
  }

  @override
  List<Object?> get props => [user, userTypes, listOfUsers, uploadLogoResponse];
}
