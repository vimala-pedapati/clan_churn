part of 'client_bloc.dart';

sealed class ClientEvent extends Equatable {
  const ClientEvent();

  @override
  List<Object> get props => [];
}

class CreateClientEvent extends ClientEvent {
  final String clinetName;
  final String roleName;
  final String address1;
  final String address2;
  final String pocName;
  final String pocContactNumber;
  final String pocMailId;
  final String image;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const CreateClientEvent({
    required this.clinetName,
    required this.roleName,
    required this.address1,
    required this.address2,
    required this.pocName,
    required this.pocContactNumber,
    required this.pocMailId,
    required this.image,
    required this.onErrorCallback,
    required this.onSuccessCallback,
  });
}

class UpdateClientEvent extends ClientEvent {
  final String clientId;
  final String clinetName;
  final String roleName;
  final String address1;
  final String address2;
  final String pocName;
  final String pocContactNumber;
  final String pocMailId;
  final String image;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const UpdateClientEvent({
    required this.clientId,
    required this.clinetName,
    required this.roleName,
    required this.address1,
    required this.address2,
    required this.pocName,
    required this.pocContactNumber,
    required this.pocMailId,
    required this.image,
    required this.onErrorCallback,
    required this.onSuccessCallback,
  });
}

class DeleteClientEvent extends ClientEvent {
  final String clientId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const DeleteClientEvent(
      {required this.clientId,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class UploadClientLogo extends ClientEvent {
  final FilePickerResult filePickerResult;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;
  const UploadClientLogo(
      {required this.filePickerResult,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}

class ArchiveProjectEvent extends ClientEvent {
  final String projectId;
  final OnErrorCallback onErrorCallback;
  final OnSuccessCallback onSuccessCallback;

  const ArchiveProjectEvent(
      {required this.projectId,
      required this.onErrorCallback,
      required this.onSuccessCallback});
}
