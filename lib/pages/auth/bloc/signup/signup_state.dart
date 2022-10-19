part of 'signup_cubit.dart';


class SignupState extends Equatable {
  final BlocState blocState;
  final String message;
  final SignupRequest signupRequest;

  const SignupState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.signupRequest = SignupRequest.empty
  });

  @override
  List<Object?> get props => [blocState, message, signupRequest];

  SignupState copyWith(
      {BlocState? blocState, String? message, SignupRequest? signupRequest}) {
    return SignupState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      signupRequest: signupRequest ?? this.signupRequest,
    );
  }
}