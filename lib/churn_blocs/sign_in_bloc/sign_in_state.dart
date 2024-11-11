part of 'sign_in_bloc.dart';

@immutable
class SignInBlocState extends Equatable {
  const SignInBlocState.initial()
      : this(
          status: AuthStatus.unauthenticated,
          isLoggingIn: false,
        );
  const SignInBlocState({
    required this.status,
    required this.isLoggingIn,
  });
  final AuthStatus status;
  final bool isLoggingIn;

  SignInBlocState copyWith({AuthStatus? status, bool? isLoggingIn}) {
    log("$status");
    return SignInBlocState(
      status: status ?? this.status,
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isLoggingIn,
      ];
}
