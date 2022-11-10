import 'dart:async';

import 'package:app/data/repositories/auth_repository.dart';
import 'package:app/models/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthState.unauthenticated()) {
    on<UserChanged>(_onUserChanged);
    //on<FetchUser>(_onFetchUser);
    on<Logout>(_onLogout);
    _userSubscription = _authenticationRepository.user.listen(
      (user) {
        add(UserChanged(user));
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(UserChanged event, Emitter<AuthState> emit) {
    if (event.user.isAccountVerified ?? false) {
      emit(
        event.user.isNotEmpty
            ? AuthState.authenticated(event.user)
            : const AuthState.unauthenticated(),
      );
    } else {
      emit(AuthState.unverified(event.user));
      emit(AuthState.unauthenticated());
    }
  }

  void _onLogout(Logout event, Emitter<AuthState> emit) {
    _authenticationRepository.logout();
  }

  // void _onFetchUser(FetchUser event, Emitter<AuthState> emit) {
  //   _authenticationRepository.fetchUser();
  // }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
