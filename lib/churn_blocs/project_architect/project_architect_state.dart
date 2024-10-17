part of 'project_architect_bloc.dart';

class ProjectArchitectState extends Equatable {
  const ProjectArchitectState.initial()
      : this(
            clientList: const [],
            isNotExpanded: false,
            selectedClient: null,
            projectsList: const [],
            columnsList: const [],
            columnsFetching: false,
            createdProject: null,
            projectCreating: false,
            customerColumnNames: const [],
            uploadingFile: false,
            errorReport: null,
            uploadNewSheetRequested: false,
            projectHistory: const [],
            projectThesholdFormfields: const [],
            allReports: const []);

  final List<ClientDetails> clientList;
  final bool isNotExpanded;
  final ClientDetails? selectedClient;
  final List<Project> projectsList;
  final List<ColumnDetails> columnsList;
  final bool columnsFetching;
  final Project? createdProject;
  final bool projectCreating;
  final List<TextEditingController> customerColumnNames;
  final bool uploadingFile;
  final String? errorReport;
  final bool uploadNewSheetRequested;
  final List<ProjectHistoryModel> projectHistory;
  final List<GetProThresholdFormValModel> projectThesholdFormfields;
  final List<String> allReports;
  const ProjectArchitectState(
      {required this.clientList,
      required this.isNotExpanded,
      required this.selectedClient,
      required this.projectsList,
      required this.columnsList,
      required this.columnsFetching,
      required this.createdProject,
      required this.projectCreating,
      required this.customerColumnNames,
      required this.uploadingFile,
      required this.errorReport,
      required this.uploadNewSheetRequested,
      required this.projectHistory,
      required this.projectThesholdFormfields,
      required this.allReports});

  ProjectArchitectState copyWith({
    List<ClientDetails>? clientList,
    bool? isNotExpanded,
    ClientDetails? selectedClient,
    List<Project>? projectsList,
    List<ColumnDetails>? columnsList,
    bool? columnsFetching,
    Project? createdProject,
    bool? projectCreating,
    List<TextEditingController>? customerColumnNames,
    bool? uploadingFile,
    String? errorReport,
    bool? uploadNewSheetRequested,
    List<ProjectHistoryModel>? projectHistory,
    List<GetProThresholdFormValModel>? projectThesholdFormfields,
    List<String>? allReports,
  }) {
    return ProjectArchitectState(
        clientList: clientList ?? this.clientList,
        isNotExpanded: isNotExpanded ?? this.isNotExpanded,
        selectedClient: selectedClient ?? this.selectedClient,
        projectsList: projectsList ?? this.projectsList,
        columnsList: columnsList ?? this.columnsList,
        columnsFetching: columnsFetching ?? this.columnsFetching,
        createdProject: createdProject ?? this.createdProject,
        projectCreating: projectCreating ?? this.projectCreating,
        customerColumnNames: customerColumnNames ?? this.customerColumnNames,
        uploadingFile: uploadingFile ?? this.uploadingFile,
        errorReport: errorReport ?? this.errorReport,
        uploadNewSheetRequested: uploadNewSheetRequested ?? this.uploadNewSheetRequested,
        projectHistory: projectHistory ?? this.projectHistory,
        projectThesholdFormfields: projectThesholdFormfields ?? this.projectThesholdFormfields,
        allReports: allReports ?? this.allReports);
  }

  @override
  List<Object?> get props => [
        clientList,
        isNotExpanded,
        selectedClient,
        projectsList,
        columnsList,
        columnsFetching,
        createdProject,
        projectCreating,
        customerColumnNames,
        uploadingFile,
        errorReport,
        uploadNewSheetRequested,
        projectHistory,
        projectThesholdFormfields,
        allReports,
      ];
}
