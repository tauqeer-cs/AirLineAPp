part of 'login_cubit.dart';

class LoginState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;

  const LoginState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
  });

  @override
  List<Object?> get props => [blocState, message, isRememberMe];

  LoginState copyWith(
      {BlocState? blocState, String? message, bool? isRememberMe}) {
    return LoginState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}
