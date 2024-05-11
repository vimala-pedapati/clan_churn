import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiRepository apiRepository;
  UserBloc({required this.apiRepository}) : super(const UserState.initial()) {
    on<GetUserDetailsEvent>(_onGetUserDetails);
  }

  _onGetUserDetails(GetUserDetailsEvent event, Emitter<UserState> emit) {
    final result = apiRepository.getUserDetails();
    log("$result");
  }
}
