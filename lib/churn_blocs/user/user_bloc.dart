import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
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
}
