part of 'sign_in_bloc.dart';

@immutable
class SignInBlocState extends Equatable {
  const SignInBlocState.initial()  : this(status: AuthStatus.unauthenticated);
  const SignInBlocState({required this.status});
   final AuthStatus status;

  SignInBlocState copyWith({AuthStatus? status}) {
    log("$status");
    return SignInBlocState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
