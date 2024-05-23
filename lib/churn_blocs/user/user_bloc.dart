import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiRepository apiRepository;
  UserBloc({required this.apiRepository}) : super(const UserState.initial()) {
    on<GetUserDetailsEvent>(_onGetUserDetails);
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
  }

  _onGetUserDetails(GetUserDetailsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getUserDetails();
    log("user profile: $result");
    if (result != null) {
      emit(state.copyWith(user: result));
    } else {}
  }

  _onClientsEvent(GetClientsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getClientsList();
    if (result != null) {
      emit(state.copyWith(clientList: result));
    } else {
      emit(state.copyWith(clientList: []));
    }
  }

  _onSideBarExpandedEvent(SideBarExpandedEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(isExpanded: event.isExpanded));
  }

  _onSetSelectedClientEvent(
      SetSelectedClientEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(selectedClient: event.selectedClient));
  }

  _onGetProjectsListEvent(
      GetProjectsListEvent event, Emitter<UserState> emit) async {
    final result =
        await apiRepository.getAllProjectDetails(clientId: event.clientId);
    if (result != null) {
      emit(state.copyWith(projectsList: result));
    } else {
      emit(state.copyWith(projectsList: []));
    }
  }

  _onGetColumnsEvent(GetColumnsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getAllColumns();
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
      CreateProjectEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.createProject(
        clientId: event.clientId, projectName: event.projectName);
    if (result != null) {
      emit(state.copyWith(createdProject: result));
      final columnsResult = await apiRepository.getAllColumns();
      if (columnsResult != null) {
        emit(state.copyWith(columnsList: columnsResult));
      } else {
        emit(state.copyWith(columnsList: []));
      }
    } else {
      emit(state.copyWith(
          createdProject: const Project(
        id: "",
        name: '',
        inputColumns: [],
        projectStatus: '',
        inputSheet: '',
        projectDetails: null,
        allInputs: [],
      )));
    }
  }

  _onClearCreateProjectEvent(
      ClearCreateProjectEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(
        createdProject: const Project(
      id: "",
      name: '',
      inputColumns: [],
      projectStatus: '',
      inputSheet: '',
      projectDetails: null,
      allInputs: [],
    )));
  }

  _onReplaceColumnsEvent(ReplaceColumnsEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(columnsList: event.columns));
  }

  _onAddColumnsToProjectEvent(
      AddColumnsToProjectEvent event, Emitter<UserState> emit) async {
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
      // print(a);
      final result = await apiRepository.addColumnsToProject(columnsToAdd: a);
      if (result != null) {
        emit(state.copyWith(createdProject: result, projectCreating: false));
      }
    }
    log("${a.length}");
  }

  _onSetCreatedProjectEvent(
      SetCreatedProjectEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(createdProject: event.createdProject));
  }

  _onUpdateProjectDetailsEvent(
      UpdateProjectDetailsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.updateProjectDetails(
        projectId: event.projectId, projectDetails: event.projectDetails);
    if (result != null) {
      emit(state.copyWith(createdProject: result));
    } else {
      emit(state.copyWith(
          createdProject: const Project(
        id: "",
        name: '',
        inputColumns: [],
        projectStatus: '',
        inputSheet: '',
        projectDetails: null,
        allInputs: [],
      )));
    }
  }

  _onGetProjectDetailsEvent(
      GetProjectDetailsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getProjectDetails(
      projectId: event.projectId,
    );
    if (result != null) {
      emit(state.copyWith(createdProject: result));
    } else {
      emit(state.copyWith(
          createdProject: const Project(
        id: "",
        name: '',
        inputColumns: [],
        projectStatus: '',
        inputSheet: '',
        projectDetails: null,
        allInputs: [],
      )));
    }
  }

  _onUploadFileEvent(UploadFileEvent event, Emitter<UserState> emit) async{
    final result = await apiRepository.uploadFile(projectId: event.projectId, filePickerResult: event.filePickerResult );
  }
}
