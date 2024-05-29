part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState.initial()
      : this(
          user: null,
        );
  final User? user;

  const UserState({
    required this.user,
  });

  UserState copyWith({
    User? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        user,
      ];
}
