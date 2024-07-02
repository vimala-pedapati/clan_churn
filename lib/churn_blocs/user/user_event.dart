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
