part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState.initial()
      : this(
            user: null,
            clientList: const [],
            isExpanded: false,
            selectedClient: null,
            projectsList: const [],
            columnsList: const []);
  final User? user;
  final List<ClientDetails> clientList;
  final bool isExpanded;
  final ClientDetails? selectedClient;
  final List<ProjectDetails> projectsList;
  final List<ColumnDetails> columnsList;
  const UserState(
      {required this.user,
      required this.clientList,
      required this.isExpanded,
      required this.selectedClient,
      required this.projectsList,
      required this.columnsList});

  UserState copyWith(
      {User? user,
      List<ClientDetails>? clientList,
      bool? isExpanded,
      ClientDetails? selectedClient,
      List<ProjectDetails>? projectsList,
      List<ColumnDetails>? columnsList}) {
    return UserState(
        user: user ?? this.user,
        clientList: clientList ?? this.clientList,
        isExpanded: isExpanded ?? this.isExpanded,
        selectedClient: selectedClient ?? this.selectedClient,
        projectsList: projectsList ?? this.projectsList,
        columnsList: columnsList ?? this.columnsList);
  }

  @override
  List<Object?> get props =>
      [user, clientList, isExpanded, selectedClient, projectsList, columnsList];
}
