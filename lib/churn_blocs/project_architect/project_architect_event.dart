part of 'project_architect_bloc.dart';

class ProjectArchitectEvent extends Equatable {
  const ProjectArchitectEvent();

  @override
  List<Object> get props => [];
}

class GetClientsEvent extends ProjectArchitectEvent {
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const GetClientsEvent({required this.onErrorCallback, required this.onSuccessCallback});
}

class SideBarExpandedEvent extends ProjectArchitectEvent {
  final bool isNotExpanded;
  const SideBarExpandedEvent({required this.isNotExpanded});
}

class SetSelectedClientEvent extends ProjectArchitectEvent {
  final ClientDetails selectedClient;
  const SetSelectedClientEvent({required this.selectedClient});
}

class GetProjectsListEvent extends ProjectArchitectEvent {
  final String clientId;
  const GetProjectsListEvent({required this.clientId});
}

class UpdateProjectDetailsEvent extends ProjectArchitectEvent {
  final String projectId;
  final ProjectDetails projectDetails;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const UpdateProjectDetailsEvent({required this.projectId, required this.projectDetails, required this.onErrorCallback, required this.onSuccessCallback});
}

class GetProjectDetailsEvent extends ProjectArchitectEvent {
  final String projectId;
  const GetProjectDetailsEvent({required this.projectId});
}

class GetColumnsEvent extends ProjectArchitectEvent {
  final String? projectId;
  const GetColumnsEvent(this.projectId);
}

class CustomerColumnNamesEvent extends ProjectArchitectEvent {
  final List<TextEditingController> customerColumnNames;
  const CustomerColumnNamesEvent({required this.customerColumnNames});
}

class CreateProjectEvent extends ProjectArchitectEvent {
  final String clientId;
  final String projectName;
  final String? projectId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const CreateProjectEvent({required this.clientId, required this.projectName, required this.onErrorCallback, required this.onSuccessCallback, required this.projectId});
}

class ClearCreateProjectEvent extends ProjectArchitectEvent {}

class ReplaceColumnsEvent extends ProjectArchitectEvent {
  final List<ColumnDetails> columns;
  final int index;
  const ReplaceColumnsEvent({required this.columns, required this.index});
}

class AddColumnsToProjectEvent extends ProjectArchitectEvent {
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const AddColumnsToProjectEvent({required this.onErrorCallback, required this.onSuccessCallback});
}

class SetCreatedProjectEvent extends ProjectArchitectEvent {
  final Project createdProject;
  const SetCreatedProjectEvent({required this.createdProject});
}

class UploadFileEvent extends ProjectArchitectEvent {
  final FilePickerResult filePickerResult;
  final String projectId;
  final BuildContext context;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallBack;
  const UploadFileEvent({required this.filePickerResult, required this.projectId, required this.context, required this.onErrorCallback, required this.onSuccessCallBack});
}

class UpdateProjectNameEvent extends ProjectArchitectEvent {
  final String projectId;
  final String updatedProjectName;
  final OnErrorCallback warningMessageCallback;
  final OnSuccessCallback onSuccessCallback;
  const UpdateProjectNameEvent({
    required this.projectId,
    required this.updatedProjectName,
    required this.warningMessageCallback,
    required this.onSuccessCallback,
  });
}

class GetInputExcelSummaryEvent extends ProjectArchitectEvent {
  final String inputId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const GetInputExcelSummaryEvent({required this.inputId, required this.onErrorCallback, required this.onSuccessCallback});
}

class DownloadErrorReportEvent extends ProjectArchitectEvent {
  final String inputId;
  final BuildContext context;

  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const DownloadErrorReportEvent({required this.inputId, required this.context, required this.onErrorCallback, required this.onSuccessCallback});
}

class UploadNewSheetRequestedEvent extends ProjectArchitectEvent {
  final bool uploadNewSheetRequested;
  const UploadNewSheetRequestedEvent({required this.uploadNewSheetRequested});
}

class ProjectInputHistoryEvent extends ProjectArchitectEvent {
  final String projectId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const ProjectInputHistoryEvent({required this.projectId, required this.onErrorCallback, required this.onSuccessCallback});
}

class GenerateMartsEvent extends ProjectArchitectEvent {
  final String inputId;

  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const GenerateMartsEvent({required this.inputId, required this.onErrorCallback, required this.onSuccessCallback});
}

class GetReportDataEvent extends ProjectArchitectEvent {
  final String reportName;
  final String inputId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const GetReportDataEvent({
    required this.reportName,
    required this.inputId,
    required this.onErrorCallback,
    required this.onSuccessCallback,
  });
}

class GetProThresholdValEvent extends ProjectArchitectEvent {
  final String projectId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const GetProThresholdValEvent({required this.projectId, required this.onErrorCallback, required this.onSuccessCallback});
}

class UpdateProThrValsEvent extends ProjectArchitectEvent {
  final String projectId;
  final List<UpdateThresholdValModel> data;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const UpdateProThrValsEvent({required this.projectId, required this.data, required this.onErrorCallback, required this.onSuccessCallback});
}

class GetAllReportsEvent extends ProjectArchitectEvent {
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const GetAllReportsEvent({required this.onErrorCallback, required this.onSuccessCallback});
}

class UpdateProjectThresholdMinValue extends ProjectArchitectEvent {
  final String thresholdId;
  final dynamic minValue;
  const UpdateProjectThresholdMinValue({required this.minValue, required this.thresholdId});
}

class UpdateProjectThresholdMaxValue extends ProjectArchitectEvent {
  final String thresholdId;
  final dynamic maxValue;
  const UpdateProjectThresholdMaxValue({required this.maxValue, required this.thresholdId});
}
