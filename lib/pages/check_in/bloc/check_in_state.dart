part of 'check_in_cubit.dart';


class CheckInState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;

  const CheckInState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
  });

  @override
  List<Object?> get props => [blocState, message, isRememberMe];

  CheckInState copyWith(
      {BlocState? blocState, String? message, bool? isRememberMe}) {
    return CheckInState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}

