part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState.initial()
      : this(
            user: null,
            clientList: const [],
            isExpanded: false,
            selectedClient: null,
            projectsList: const [],
            columnsList: const [],
            createdProject: null, 
            projectCreating: false);
  final User? user;
  final List<ClientDetails> clientList;
  final bool isExpanded;
  final ClientDetails? selectedClient;
  final List<ProjectDetails> projectsList;
  final List<ColumnDetails> columnsList;
  final ProjectDetails? createdProject;
  final bool projectCreating;
  const UserState(
      {required this.user,
      required this.clientList,
      required this.isExpanded,
      required this.selectedClient,
      required this.projectsList,
      required this.columnsList,
      required this.createdProject, required this.projectCreating});

  UserState copyWith(
      {User? user,
      List<ClientDetails>? clientList,
      bool? isExpanded,
      ClientDetails? selectedClient,
      List<ProjectDetails>? projectsList,
      List<ColumnDetails>? columnsList,
      ProjectDetails? createdProject,
      bool? projectCreating}) {
    return UserState(
        user: user ?? this.user,
        clientList: clientList ?? this.clientList,
        isExpanded: isExpanded ?? this.isExpanded,
        selectedClient: selectedClient ?? this.selectedClient,
        projectsList: projectsList ?? this.projectsList,
        columnsList: columnsList ?? this.columnsList,
        createdProject: createdProject ?? this.createdProject,
        projectCreating:  projectCreating ?? this.projectCreating);
  }

  @override
  List<Object?> get props => [
        user,
        clientList,
        isExpanded,
        selectedClient,
        projectsList,
        columnsList,
        createdProject,
        projectCreating
      ];
}
