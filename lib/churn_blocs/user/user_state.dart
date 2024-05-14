part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState.initial()
      : this(user: null, clientList: const [], isExpanded: false, selectedClient: null);
  final User? user;
  final List<ClientDetails> clientList;
  final bool isExpanded;
  final ClientDetails? selectedClient;
  const UserState(
      {required this.user, required this.clientList, required this.isExpanded, required this.selectedClient});

  UserState copyWith(
      {User? user, List<ClientDetails>? clientList, bool? isExpanded,ClientDetails? selectedClient}) {
    return UserState(
        user: user ?? this.user,
        clientList: clientList ?? this.clientList,
        isExpanded: isExpanded ?? this.isExpanded,
        selectedClient: selectedClient ?? this.selectedClient);
  }

  @override
  List<Object?> get props => [user, clientList, isExpanded, selectedClient];
}
