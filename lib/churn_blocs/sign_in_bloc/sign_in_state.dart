part of 'sign_in_bloc.dart';

@immutable
class SignInBlocState extends Equatable {
  const SignInBlocState.initial()  : this(status: AuthenticationStatus.unauthenticated);
  const SignInBlocState({required this.status});
   final AuthenticationStatus status;

  SignInBlocState copyWith({AuthenticationStatus? status}) {
    log("$status");
    return SignInBlocState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
