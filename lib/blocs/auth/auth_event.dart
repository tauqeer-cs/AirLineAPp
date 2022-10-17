part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class UserChanged extends AuthEvent {
  final User user;

  const UserChanged(this.user);

  @override
  List<Object?> get props => [user];
}

class FetchUser extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class Logout extends AuthEvent {
  @override
  List<Object?> get props => [];
}

