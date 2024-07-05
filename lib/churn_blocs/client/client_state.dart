part of 'client_bloc.dart';

class ClientState extends Equatable {
  const ClientState({required this.clientUploadLogoResponse});
  const ClientState.initial() : this(clientUploadLogoResponse: null);
  final ClientUploadLogoResponse? clientUploadLogoResponse;

  ClientState copyWith({ClientUploadLogoResponse? clientUploadLogoResponse}) {
    return ClientState(
        clientUploadLogoResponse:
            clientUploadLogoResponse ?? this.clientUploadLogoResponse);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [clientUploadLogoResponse];
}
