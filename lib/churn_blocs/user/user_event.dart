part of 'user_bloc.dart';

class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class GetUserDetailsEvent extends UserEvent {}

class GetClientsEvent extends UserEvent {}

class SideBarExpandedEvent extends UserEvent {
  final bool isExpanded;
  const SideBarExpandedEvent({required this.isExpanded});
}
