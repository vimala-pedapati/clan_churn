part of 'client_bloc.dart';

class ClientState extends Equatable {
  const ClientState({
    required this.clientUploadLogoResponse,
    required this.updatingClient,
  });
  const ClientState.initial()
      : this(
          clientUploadLogoResponse: null,
          updatingClient: false,
        );
  final UploadLogoResponse? clientUploadLogoResponse;
  final bool updatingClient;

  ClientState copyWith({
    UploadLogoResponse? clientUploadLogoResponse,
    bool? updatingClient,
  }) {
    return ClientState(
      clientUploadLogoResponse: clientUploadLogoResponse ?? this.clientUploadLogoResponse,
      updatingClient: updatingClient ?? this.updatingClient,
    );
  }

  @override
  List<Object?> get props => [
        clientUploadLogoResponse,
        updatingClient,
      ];
}
