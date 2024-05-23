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

class SetSelectedClientEvent extends UserEvent {
  final ClientDetails selectedClient;
  const SetSelectedClientEvent({required this.selectedClient});
}

class GetProjectsListEvent extends UserEvent {
  final String clientId;
  const GetProjectsListEvent({required this.clientId});
}

class GetColumnsEvent extends UserEvent {
  const GetColumnsEvent();
}

class CustomerColumnNamesEvent extends UserEvent {
  final List<TextEditingController> customerColumnNames;
  const CustomerColumnNamesEvent({required this.customerColumnNames});
}

class CreateProjectEvent extends UserEvent {
  final String clientId;
  final String projectName;
  const CreateProjectEvent({required this.clientId, required this.projectName});
}

class ClearCreateProjectEvent extends UserEvent{}

class ReplaceColumnsEvent extends UserEvent {
  final List<ColumnDetails> columns;
  final int index;
  const ReplaceColumnsEvent({required this.columns, required this.index});
}

class AddColumnsToProjectEvent extends UserEvent {}

class SetCreatedProjectEvent extends UserEvent {
  final Project createdProject;
  const SetCreatedProjectEvent({required this.createdProject});
}
