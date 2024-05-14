part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState.initial() : this(user: null, clientList: const [], isExpanded: false);
  final User? user;
  final List<ClientDetails> clientList;
  final bool isExpanded;
  const UserState({required this.user, required this.clientList, required this.isExpanded});

  UserState copyWith({User? user, List<ClientDetails>? clientList, bool? isExpanded }) {
    return UserState(
        user: user ?? this.user, clientList: clientList ?? this.clientList, 
        isExpanded: isExpanded ?? this.isExpanded);
  }

  @override
  List<Object?> get props => [user, clientList, isExpanded];
}
