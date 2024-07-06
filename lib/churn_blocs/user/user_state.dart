part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState.initial() : this(user: null, userTypes: const []);
  final User? user;
  final List<String> userTypes;

  const UserState({required this.user, required this.userTypes});

  UserState copyWith({User? user, List<String>? userTypes}) {
    return UserState(
        user: user ?? this.user, userTypes: userTypes ?? this.userTypes);
  }

  @override
  List<Object?> get props => [user, userTypes];
}
