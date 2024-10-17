import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/client_details.dart';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/get_pro_threshold_val_model.dart';
import 'package:clan_churn/api_repos/models/project_history_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/api_repos/models/update_threshold_val_model.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:clan_churn/components/input_sheet_columns.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

part 'project_architect_event.dart';
part 'project_architect_state.dart';

class ProjectArchitectBloc extends Bloc<ProjectArchitectEvent, ProjectArchitectState> {
  ApiRepository apiRepository;
  ProjectArchitectBloc({required this.apiRepository}) : super(const ProjectArchitectState.initial()) {
    on<GetClientsEvent>(_onClientsEvent);
    on<SideBarExpandedEvent>(_onSideBarExpandedEvent);
    on<SetSelectedClientEvent>(_onSetSelectedClientEvent);
    on<GetProjectsListEvent>(_onGetProjectsListEvent);
    on<GetColumnsEvent>(_onGetColumnsEvent);
    on<CreateProjectEvent>(_onCreateProjectEvent);
    on<ClearCreateProjectEvent>(_onClearCreateProjectEvent);
    on<ReplaceColumnsEvent>(_onReplaceColumnsEvent);
    on<AddColumnsToProjectEvent>(_onAddColumnsToProjectEvent);
    on<SetCreatedProjectEvent>(_onSetCreatedProjectEvent);
    on<UpdateProjectDetailsEvent>(_onUpdateProjectDetailsEvent);
    on<GetProjectDetailsEvent>(_onGetProjectDetailsEvent);
    on<UploadFileEvent>(_onUploadFileEvent);
    on<UpdateProjectNameEvent>(_onUpdateProjectNameEvent);
    on<GetInputExcelSummaryEvent>(_onGetInputExcelSummaryEvent);
    on<DownloadErrorReportEvent>(_onDownloadErrorReportEvent);
    on<UploadNewSheetRequestedEvent>(_onUploadNewSheetRequestedEvent);
    on<ProjectInputHistoryEvent>(_onProjectInputHistoryEvent);
    on<GenerateMartsEvent>(_onGenerateMartsEvent);
    on<GetReportDataEvent>(_onGetReportDataEvent);
    on<GetProThresholdValEvent>(_onGetProThresholdValEvent);
    on<UpdateProThrValsEvent>(_onUpdateProThrValsEvent);
    on<GetAllReportsEvent>(_onGetAllReports);
  }

  _onClientsEvent(GetClientsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getClientsList(onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
    if (result != null) {
      emit(state.copyWith(clientList: result));
    } else {
      emit(state.copyWith(clientList: []));
    }
  }

  _onSideBarExpandedEvent(SideBarExpandedEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(isNotExpanded: event.isNotExpanded));
  }

  _onSetSelectedClientEvent(SetSelectedClientEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(selectedClient: event.selectedClient));
  }

  _onGetProjectsListEvent(GetProjectsListEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getAllProjectDetails(
        clientId: event.clientId,
        onErrorCallback: (String message, int errorCode) {
          log(" getAllProjectDetails error call back: error message: $message error code: $errorCode");
        });
    if (result != null) {
      emit(state.copyWith(projectsList: result));
    } else {
      emit(state.copyWith(projectsList: []));
    }
  }

  _onGetColumnsEvent(GetColumnsEvent event, Emitter<ProjectArchitectState> emit) async {
    emit(state.copyWith(columnsFetching: true));
    final result = await apiRepository.getAllColumns(
        projectId: event.projectId,
        onErrorCallback: (String message, int errorCode) {
          log(" $message");
        });
    if (result != null) {
      emit(state.copyWith(columnsList: result));
      List<TextEditingController> a = [];
      for (var i in result) {
        a.add(TextEditingController(text: i.clientColumnName));
      }
      emit(state.copyWith(customerColumnNames: a));
    } else {
      emit(state.copyWith(columnsList: []));
    }
    emit(state.copyWith(columnsFetching: false));
  }

  _onCreateProjectEvent(CreateProjectEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.createProject(clientId: event.clientId, projectName: event.projectName, onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
    if (result != null) {
      emit(state.copyWith(createdProject: result));

      // final columnsResult = await apiRepository.getAllColumns(
      //     projectId: result.id,
      //     onErrorCallback: (String message, int errorCode) {
      //       log(" $message");
      //     });
      // if (columnsResult != null) {
      //   emit(state.copyWith(columnsList: columnsResult));
      // } else {
      //   emit(state.copyWith(columnsList: []));
      // }
    } else {
      emit(state.copyWith(createdProject: const Project(id: "", name: null, inputColumns: null, projectStatus: null, inputSheet: null, projectDetails: null, allInputs: null, latestInput: null, latestInputModel: null)));
    }
  }

  _onClearCreateProjectEvent(ClearCreateProjectEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(createdProject: const Project(id: "", name: null, inputColumns: null, projectStatus: null, inputSheet: null, projectDetails: null, allInputs: null, latestInput: null, latestInputModel: null)));
  }

  _onReplaceColumnsEvent(ReplaceColumnsEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(columnsList: event.columns));
  }

  _onAddColumnsToProjectEvent(AddColumnsToProjectEvent event, Emitter<ProjectArchitectState> emit) async {
    emit(state.copyWith(projectCreating: true));
    List a = [];
    if (state.createdProject != null) {
      for (int i = 0; i < state.columnsList.length; i++) {
        // if (i.isUserCheckedIn) {
        a.add({"column_id": state.columnsList[i].id, "project_id": state.createdProject!.id, "add": state.columnsList[i].isUserCheckedIn, "client_column_name": state.customerColumnNames[i].text});
        // }
      }
      // print(a);
      final result = await apiRepository.addColumnsToProject(columnsToAdd: a, onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
      if (result != null) {
        emit(state.copyWith(createdProject: result, projectCreating: false));
      }
    }
    log("${a.length}");
  }

  _onSetCreatedProjectEvent(SetCreatedProjectEvent event, Emitter<ProjectArchitectState> emit) {
    add(GetProjectDetailsEvent(projectId: event.createdProject.id));
    emit(state.copyWith(createdProject: event.createdProject));
  }

  _onUpdateProjectDetailsEvent(UpdateProjectDetailsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.updateProjectDetails(projectId: event.projectId, projectDetails: event.projectDetails, onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
    if (result != null) {
      emit(state.copyWith(createdProject: result));
    } else {
      emit(state.copyWith(createdProject: const Project(id: "", name: null, inputColumns: null, projectStatus: null, inputSheet: null, projectDetails: null, allInputs: null, latestInput: null, latestInputModel: null)));
    }
  }

  _onGetProjectDetailsEvent(GetProjectDetailsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getProjectDetails(
        projectId: event.projectId,
        onErrorCallback: (String message, int errorCode) {
          log(" $message");
        });

    if (result != null) {
      print("get project details result if case $result");
      emit(state.copyWith(createdProject: result));
    } else {
      log("get project details result else case");
      emit(state.copyWith(createdProject: const Project(id: "", name: null, inputColumns: null, projectStatus: null, inputSheet: null, projectDetails: null, allInputs: null, latestInput: null, latestInputModel: null)));
    }
  }

  _onUploadFileEvent(UploadFileEvent event, Emitter<ProjectArchitectState> emit) async {
    emit(state.copyWith(uploadingFile: true));
    GetDialog.uploadFile(event.context);
    final result = await apiRepository.uploadFile(projectId: event.projectId, filePickerResult: event.filePickerResult, onSuccessCallback: event.onSuccessCallBack, onErrorCallback: event.onErrorCallback);
    log("upload file result: $result");
    if (result != null) {
      emit(state.copyWith(uploadingFile: false, createdProject: result, uploadNewSheetRequested: false));
      // ignore: use_build_context_synchronously
      Navigator.pop(event.context);
    } else {
      log("upload file result else case: $result");
      // ignore: use_build_context_synchronously
      Navigator.pop(event.context);

      emit(state.copyWith(uploadingFile: false, errorReport: null, uploadNewSheetRequested: false));
    }
  }

  _onDownloadErrorReportEvent(DownloadErrorReportEvent event, Emitter<ProjectArchitectState> emit) async {
    final res = await apiRepository.getErrorReportForInput(
      inputId: event.inputId,
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
    if (res != null) {
      Project pro = state.createdProject!.copyWith(latestInputModel: res);
      if (pro.latestInputModel!.errorSheetUrl != null) {
        launchURL(pro.latestInputModel!.errorSheetUrl!);
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: event.context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              surfaceTintColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(08),
              ),
              title: Text(pro.latestInputModel?.inputStatus == InputStatus.uploadedDataHasNoErrors ? "No errors in the uploaded data ready to publish" : "something went wrong to download"),
            );
          },
        );
      }

      emit(state.copyWith(createdProject: pro));
    }
  }

  _onUpdateProjectNameEvent(UpdateProjectNameEvent event, Emitter<ProjectArchitectState> emit) async {
    var result = await ApiRepository().updateProjectName(projectId: event.projectId, updatedProjectName: event.updatedProjectName, onErrorCallback: event.warningMessageCallback, onSuccessCallback: event.onSuccessCallback);

    if (result != null) {
      emit(state.copyWith(createdProject: result));
    }
  }

  _onGetInputExcelSummaryEvent(GetInputExcelSummaryEvent event, Emitter<ProjectArchitectState> emit) {
    apiRepository.getInputExcelSummaryReport(inputId: event.inputId, onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
  }

  _onUploadNewSheetRequestedEvent(UploadNewSheetRequestedEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(uploadNewSheetRequested: event.uploadNewSheetRequested));
  }

  _onProjectInputHistoryEvent(ProjectInputHistoryEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getProjectHistoryDetails(projectId: event.projectId, onSuccessCallback: event.onSuccessCallback, onErrorCallback: event.onErrorCallback);
    if (result != null) {
      emit(state.copyWith(projectHistory: result));
    } else {
      emit(state.copyWith(projectHistory: []));
    }
  }

  _onGenerateMartsEvent(GenerateMartsEvent event, Emitter<ProjectArchitectState> emit) async {
    final res = await apiRepository.generateMarts(
      inputId: event.inputId,
      onErrorCallback: event.onErrorCallback,
      onSuccessCallback: event.onSuccessCallback,
    );
    if (res != null) {
      launchURL(res);
      // Project pro = state.createdProject!.copyWith(latestInputModel: res);
      // if (kDebugMode) {
      //   print("${pro.latestInputModel!.martsSheetUrl!}");
      // }
      // launchURL(pro.latestInputModel!.martsSheetUrl!);
      // emit(state.copyWith(createdProject: pro));
    }
  }

  _onGetReportDataEvent(GetReportDataEvent event, Emitter<ProjectArchitectState> emit) async {
    await apiRepository.getReportData(inputId: event.inputId, reportname: event.reportName, onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
  }

  _onGetProThresholdValEvent(GetProThresholdValEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getProThresholdValues(projectId: event.projectId, onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
    if (result != null) {
      emit(state.copyWith(projectThesholdFormfields: result));
    } else {
      emit(state.copyWith(projectThesholdFormfields: []));
    }
  }

  _onUpdateProThrValsEvent(UpdateProThrValsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.updateThresholdValue(projectId: event.projectId, data: event.data, onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
    if (result != null) {
      emit(state.copyWith(createdProject: result));
    }
  }

  _onGetAllReports(GetAllReportsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getAllReports(onErrorCallback: event.onErrorCallback, onSuccessCallback: event.onSuccessCallback);
    if (result != null) {
      emit(state.copyWith(allReports: result));
    }
  }
}
