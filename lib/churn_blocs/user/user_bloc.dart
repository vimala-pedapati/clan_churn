import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/column_model.dart';
import 'package:clan_churn/api_repos/models/project_model.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:equatable/equatable.dart';

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
  }

  _onGetUserDetails(GetUserDetailsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getUserDetails();
    log("user profile: $result");
    if (result != null) {
      emit(state.copyWith(user: result));
    }
  }

  _onClientsEvent(GetClientsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getClientsList();
    if (result != null) {
      emit(state.copyWith(clientList: result));
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
        await apiRepository.getProjectDetails(clientId: event.clientId);
    if (result != null) {
      emit(state.copyWith(projectsList: result));
    }
  }

  _onGetColumnsEvent(GetColumnsEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.getAllColumns();
    if (result != null) {
      emit(state.copyWith(columnsList: result));
    }
  }

  _onCreateProjectEvent(
      CreateProjectEvent event, Emitter<UserState> emit) async {
    final result = await apiRepository.createProject(
        clientId: event.clientId, projectName: event.projectName);
    if (result != null) {
      emit(state.copyWith(createdProject: result));
      final columnsResult = await apiRepository.getAllColumns();
      if(columnsResult != null){
       emit(state.copyWith(columnsList: columnsResult));
      }
    }
  }
}
