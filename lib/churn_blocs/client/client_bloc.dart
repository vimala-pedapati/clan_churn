import 'package:bloc/bloc.dart';
import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/models/client_logo_upload_res.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  ApiRepository apiRepository;
  ClientBloc({required this.apiRepository})
      : super(const ClientState.initial()) {
    on<CreateClientEvent>(onCreateClientEvent);
    on<UpdateClientEvent>(onUpdateClientEvent);
    on<DeleteClientEvent>(onDeleteClientEvent);
    on<UploadClientLogo>(onUploadClientLogo);
    on<ArchiveProjectEvent>(onArchiveProjectEvent);
  }
  onCreateClientEvent(
      CreateClientEvent event, Emitter<ClientState> emit) async {
    final result = await apiRepository.clientCreate(
        clientName: event.clinetName,
        roleName: event.roleName,
        address1: event.address1,
        address2: event.address2,
        pocName: event.pocName,
        pocContactNumber: event.pocContactNumber,
        pocMailId: event.pocMailId,
        image: event.image,
        assignedProjectArc: event.assignedProjectArc,
        onErrorCallback: event.onErrorCallback,
        onSuccessCallback: event.onSuccessCallback);
  }

  onUpdateClientEvent(
      UpdateClientEvent event, Emitter<ClientState> emit) async {
    final result = await apiRepository.clientUpdate(
        clientId: event.clientId,
        clientName: event.clinetName,
        roleName: event.roleName,
        address1: event.address1,
        address2: event.address2,
        pocName: event.pocName,
        pocContactNumber: event.pocContactNumber,
        pocMailId: event.pocMailId,
        image: event.image,
        assignedProjectArc: event.assignedProjectArc,
        onErrorCallback: event.onErrorCallback,
        onSuccessCallback: event.onSuccessCallback);
  }

  onDeleteClientEvent(
      DeleteClientEvent event, Emitter<ClientState> emit) async {
    final result = await apiRepository.deleteClient(
        clientId: event.clientId,
        onErrorCallback: event.onErrorCallback,
        onSuccessCallback: event.onSuccessCallback);
  }

  onUploadClientLogo(UploadClientLogo event, Emitter<ClientState> emit) async {
    final result = await apiRepository.uploadClientLogo(
        filePickerResult: event.filePickerResult,
        onErrorCallback: event.onErrorCallback,
        onSuccessCallback: event.onSuccessCallback);

    if (result != null) {
      emit(state.copyWith(clientUploadLogoResponse: result));
    }
  }

  onArchiveProjectEvent(
      ArchiveProjectEvent event, Emitter<ClientState> emit) async {
    final result = apiRepository.archiveProject(
        projectId: event.projectId,
        onErrorCallback: event.onErrorCallback,
        onSuccessCallback: event.onSuccessCallback);
  }
}
