import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/components/dialogs.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
part 'project_architect_event.dart';
part 'project_architect_state.dart';

class ProjectArchitectBloc
    extends Bloc<ProjectArchitectEvent, ProjectArchitectState> {
  ApiRepository apiRepository;
  ProjectArchitectBloc({required this.apiRepository})
      : super(const ProjectArchitectState.initial()) {
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
  }

  _onClientsEvent(
      GetClientsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getClientsList(
        onErrorCallback: (String message, int errorCode) {
      log(" $message");
    });
    if (result != null) {
      emit(state.copyWith(clientList: result));
    } else {
      emit(state.copyWith(clientList: []));
    }
  }

  _onSideBarExpandedEvent(
      SideBarExpandedEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(isExpanded: event.isExpanded));
  }

  _onSetSelectedClientEvent(
      SetSelectedClientEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(selectedClient: event.selectedClient));
  }

  _onGetProjectsListEvent(
      GetProjectsListEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getAllProjectDetails(
        clientId: event.clientId,
        onErrorCallback: (String message, int errorCode) {
          log(" $message");
        });
    if (result != null) {
      emit(state.copyWith(projectsList: result));
    } else {
      emit(state.copyWith(projectsList: []));
    }
  }

  _onGetColumnsEvent(
      GetColumnsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getAllColumns(
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
  }

  _onCreateProjectEvent(
      CreateProjectEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.createProject(
        clientId: event.clientId,
        projectName: event.projectName,
        onErrorCallback: event.onErrorCallback,
        onSuccessCallback: event.onSuccessCallback);
    if (result != null) {
      emit(state.copyWith(createdProject: result));
      final columnsResult = await apiRepository.getAllColumns(
          onErrorCallback: (String message, int errorCode) {
        log(" $message");
      });
      if (columnsResult != null) {
        emit(state.copyWith(columnsList: columnsResult));
      } else {
        emit(state.copyWith(columnsList: []));
      }
    } else {
      emit(state.copyWith(
          createdProject: const Project(
              id: "",
              name: null,
              inputColumns: null,
              projectStatus: null,
              inputSheet: null,
              projectDetails: null,
              allInputs: null,
              latestInput: null)));
    }
  }

  _onClearCreateProjectEvent(
      ClearCreateProjectEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(
        createdProject: const Project(
            id: "",
            name: null,
            inputColumns: null,
            projectStatus: null,
            inputSheet: null,
            projectDetails: null,
            allInputs: null,
            latestInput: null)));
  }

  _onReplaceColumnsEvent(
      ReplaceColumnsEvent event, Emitter<ProjectArchitectState> emit) {
    emit(state.copyWith(columnsList: event.columns));
  }

  _onAddColumnsToProjectEvent(AddColumnsToProjectEvent event,
      Emitter<ProjectArchitectState> emit) async {
    emit(state.copyWith(projectCreating: true));
    List a = [];
    if (state.createdProject != null) {
      for (int i = 0; i < state.columnsList.length; i++) {
        // if (i.isUserCheckedIn) {
        a.add({
          "column_id": state.columnsList[i].id,
          "project_id": state.createdProject!.id,
          "add": state.columnsList[i].isMandatory,
          "client_column_name": state.customerColumnNames[i].text
        });
        // }
      }
      // log(a);
      final result = await apiRepository.addColumnsToProject(
          columnsToAdd: a,
          onErrorCallback: (String message, int errorCode) {
            log(" $message");
          });
      if (result != null) {
        emit(state.copyWith(createdProject: result, projectCreating: false));
      }
    }
    log("${a.length}");
  }

  _onSetCreatedProjectEvent(
      SetCreatedProjectEvent event, Emitter<ProjectArchitectState> emit) {
    add(GetProjectDetailsEvent(projectId: event.createdProject.id));
    emit(state.copyWith(createdProject: event.createdProject));
  }

  _onUpdateProjectDetailsEvent(UpdateProjectDetailsEvent event,
      Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.updateProjectDetails(
        projectId: event.projectId,
        projectDetails: event.projectDetails,
        onErrorCallback: (String message, int errorCode) {
          log(" $message");
        });
    if (result != null) {
      emit(state.copyWith(createdProject: result));
    } else {
      emit(state.copyWith(
          createdProject: const Project(
              id: "",
              name: null,
              inputColumns: null,
              projectStatus: null,
              inputSheet: null,
              projectDetails: null,
              allInputs: null,
              latestInput: null)));
    }
  }

  _onGetProjectDetailsEvent(
      GetProjectDetailsEvent event, Emitter<ProjectArchitectState> emit) async {
    final result = await apiRepository.getProjectDetails(
        projectId: event.projectId,
        onErrorCallback: (String message, int errorCode) {
          log(" $message");
        });

    if (result != null) {
      log("get project details result if case");
      emit(state.copyWith(createdProject: result));
    } else {
      log("get project details result else case");
      emit(state.copyWith(
          createdProject: const Project(
              id: "",
              name: null,
              inputColumns: null,
              projectStatus: null,
              inputSheet: null,
              projectDetails: null,
              allInputs: null,
              latestInput: null)));
    }
  }

  _onUploadFileEvent(
      UploadFileEvent event, Emitter<ProjectArchitectState> emit) async {
    emit(state.copyWith(uploadingFile: true));
    GetDialog.uploadFile(event.context);
    final result = await apiRepository.uploadFile(
        projectId: event.projectId,
        filePickerResult: event.filePickerResult,
        onSuccessCallback: event.onSuccessCallBack,
        onErrorCallback: event.onErrorCallback);
    log("upload file result: $result");
    if (result != null) {
      emit(state.copyWith(uploadingFile: false, createdProject: result));
      // ignore: use_build_context_synchronously
      Navigator.pop(event.context);
      if (result.latestInput != null) {
        final res = await apiRepository.getErrorReportForInput(
          inputId: result.latestInput!,
          onErrorCallback: event.onErrorCallback,
          onSuccessCallback: (message) {
            ApiRepository().handleSuccessMessage(
                "Ready to download error report!.......", event.context);
          },
        );
        if (res != null) {
          emit(state.copyWith(errorReport: res.replaceAll('"', "")));
          return;
        } else {
          emit(state.copyWith(errorReport: null));
        }
      } else {
        emit(state.copyWith(uploadingFile: false, createdProject: result));
      }
    } else {
      log("upload file result else case: $result");

      // ignore: use_build_context_synchronously
      Navigator.pop(event.context);
      // ignore: use_build_context_synchronously
      GetDialog.failedErrorReport(event.context);
      emit(state.copyWith(uploadingFile: false, errorReport: null));
    }
  }

  _onUpdateProjectNameEvent(
      UpdateProjectNameEvent event, Emitter<ProjectArchitectState> emit) async {
    var result = await ApiRepository().updateProjectName(
        projectId: event.projectId,
        updatedProjectName: event.updatedProjectName,
        onErrorCallback: event.warningMessageCallback,
        onSuccessCallback: event.onSuccessCallback);

    if (result != null) {
      emit(state.copyWith(createdProject: result));
    }
  }

  _onGetInputExcelSummaryEvent(
      GetInputExcelSummaryEvent event, Emitter<ProjectArchitectState> emit) {
    final result = apiRepository.getInputExcelSummaryReport(
        inputId: event.inputId,
        onErrorCallback: event.onErrorCallback,
        onSuccessCallback: event.onSuccessCallback);
  }
}
