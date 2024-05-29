part of 'project_architect_bloc.dart';

 class ProjectArchitectState extends Equatable {
   const ProjectArchitectState.initial()
      : this(
            clientList: const [],
            isExpanded: false,
            selectedClient: null,
            projectsList: const [],
            columnsList: const [],
            createdProject: null,
            projectCreating: false,
            customerColumnNames: const [],
            uploadingFile: false,
            errorReport: null);

  final List<ClientDetails> clientList;
  final bool isExpanded;
  final ClientDetails? selectedClient;
  final List<Project> projectsList;
  final List<ColumnDetails> columnsList;
  final Project? createdProject;
  final bool projectCreating;
  final List<TextEditingController> customerColumnNames;
  final bool uploadingFile;
  final String? errorReport;
  const ProjectArchitectState(
      {required this.clientList,
      required this.isExpanded,
      required this.selectedClient,
      required this.projectsList,
      required this.columnsList,
      required this.createdProject,
      required this.projectCreating,
      required this.customerColumnNames,
      required this.uploadingFile,
      required this.errorReport});

  ProjectArchitectState copyWith(
      {List<ClientDetails>? clientList,
      bool? isExpanded,
      ClientDetails? selectedClient,
      List<Project>? projectsList,
      List<ColumnDetails>? columnsList,
      Project? createdProject,
      bool? projectCreating,
      List<TextEditingController>? customerColumnNames,
      bool? uploadingFile,
      String? errorReport}) {
    return ProjectArchitectState(
        clientList: clientList ?? this.clientList,
        isExpanded: isExpanded ?? this.isExpanded,
        selectedClient: selectedClient ?? this.selectedClient,
        projectsList: projectsList ?? this.projectsList,
        columnsList: columnsList ?? this.columnsList,
        createdProject: createdProject ?? this.createdProject,
        projectCreating: projectCreating ?? this.projectCreating,
        customerColumnNames: customerColumnNames ?? this.customerColumnNames,
        uploadingFile: uploadingFile ?? this.uploadingFile,
        errorReport: errorReport ?? this.errorReport);
  }

  @override
  List<Object?> get props => [
        clientList,
        isExpanded,
        selectedClient,
        projectsList,
        columnsList,
        createdProject,
        projectCreating,
        customerColumnNames,
        uploadingFile,
        errorReport
      ];
}

 
