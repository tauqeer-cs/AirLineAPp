part of 'auth_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
  unverified,
}

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user,
  });

  const AuthState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  const AuthState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  const AuthState.unverified(User user)
      : this._(status: AppStatus.unverified, user: user);

  final AppStatus status;
  final User? user;

  @override
  List<Object?> get props => [status, user];
}
