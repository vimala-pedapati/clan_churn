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
            projectCreating: false,
            customerColumnNames: const [],
            uploadingFile:  false);
  final User? user;
  final List<ClientDetails> clientList;
  final bool isExpanded;
  final ClientDetails? selectedClient;
  final List<Project> projectsList;
  final List<ColumnDetails> columnsList;
  final Project? createdProject;
  final bool projectCreating;
  final List<TextEditingController> customerColumnNames;
  final bool uploadingFile;
  const UserState(
      {required this.user,
      required this.clientList,
      required this.isExpanded,
      required this.selectedClient,
      required this.projectsList,
      required this.columnsList,
      required this.createdProject,
      required this.projectCreating,
      required this.customerColumnNames,
      required this.uploadingFile});

  UserState copyWith(
      {User? user,
      List<ClientDetails>? clientList,
      bool? isExpanded,
      ClientDetails? selectedClient,
      List<Project>? projectsList,
      List<ColumnDetails>? columnsList,
      Project? createdProject,
      bool? projectCreating,
      List<TextEditingController>? customerColumnNames,
      bool? uploadingFile,
   
      }) {
    return UserState(
        user: user ?? this.user,
        clientList: clientList ?? this.clientList,
        isExpanded: isExpanded ?? this.isExpanded,
        selectedClient: selectedClient ?? this.selectedClient,
        projectsList: projectsList ?? this.projectsList,
        columnsList: columnsList ?? this.columnsList,
        createdProject: createdProject ?? this.createdProject,
        projectCreating: projectCreating ?? this.projectCreating,
        customerColumnNames: customerColumnNames ?? this.customerColumnNames,
        uploadingFile : uploadingFile ?? this.uploadingFile);
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
        projectCreating,
        customerColumnNames,
        uploadingFile
      ];
}
