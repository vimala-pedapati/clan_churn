part of 'project_architect_bloc.dart';

class ProjectArchitectEvent extends Equatable {
  const ProjectArchitectEvent();

  @override
  List<Object> get props => [];
}

class GetClientsEvent extends ProjectArchitectEvent {}

class SideBarExpandedEvent extends ProjectArchitectEvent {
  final bool isExpanded;
  const SideBarExpandedEvent({required this.isExpanded});
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
  const UpdateProjectDetailsEvent(
      {required this.projectId, required this.projectDetails});
}

class GetProjectDetailsEvent extends ProjectArchitectEvent {
  final String projectId;
  const GetProjectDetailsEvent({required this.projectId});
}

class GetColumnsEvent extends ProjectArchitectEvent {
  const GetColumnsEvent();
}

class CustomerColumnNamesEvent extends ProjectArchitectEvent {
  final List<TextEditingController> customerColumnNames;
  const CustomerColumnNamesEvent({required this.customerColumnNames});
}

class CreateProjectEvent extends ProjectArchitectEvent {
  final String clientId;
  final String projectName;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const CreateProjectEvent({
    required this.clientId,
    required this.projectName,
    required this.onErrorCallback,
    required this.onSuccessCallback,
  });
}

class ClearCreateProjectEvent extends ProjectArchitectEvent {}

class ReplaceColumnsEvent extends ProjectArchitectEvent {
  final List<ColumnDetails> columns;
  final int index;
  const ReplaceColumnsEvent({required this.columns, required this.index});
}

class AddColumnsToProjectEvent extends ProjectArchitectEvent {}

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
  const UploadFileEvent(
      {required this.filePickerResult,
      required this.projectId,
      required this.context,
      required this.onErrorCallback,
      required this.onSuccessCallBack});
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
  const GetInputExcelSummaryEvent(
      {required this.inputId,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class DownloadErrorReportEvent extends ProjectArchitectEvent {
  final String inputId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const DownloadErrorReportEvent(
      {required this.inputId,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class UploadNewSheetRequestedEvent extends ProjectArchitectEvent {
  final bool uploadNewSheetRequested;
  const UploadNewSheetRequestedEvent({required  this.uploadNewSheetRequested});
}


class ProjectInputHistoryEvent extends ProjectArchitectEvent{
   final String projectId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const ProjectInputHistoryEvent({required this.projectId, required this.onErrorCallback, required this.onSuccessCallback}); 
}
