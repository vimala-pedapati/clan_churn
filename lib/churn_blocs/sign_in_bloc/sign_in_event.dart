part of 'sign_in_bloc.dart';

class SignInBlocEvent extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SignInEvent extends SignInBlocEvent {
  final String email;
  final String password;
  final BuildContext context;
  SignInEvent(
      {required this.email, required this.password, required this.context});
}

class SignOutEvent extends SignInBlocEvent {
  final BuildContext context;
  SignOutEvent({required this.context});
}
