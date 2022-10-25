part of 'deals_cubit.dart';


class DealsState extends Equatable {
  final BlocState blocState;
  final String message;
  final bool isRememberMe;

  const DealsState({
    this.blocState = BlocState.initial,
    this.message = "",
    this.isRememberMe = true,
  });

  @override
  List<Object?> get props => [blocState, message, isRememberMe];

  DealsState copyWith(
      {BlocState? blocState, String? message, bool? isRememberMe}) {
    return DealsState(
      message: message ?? this.message,
      blocState: blocState ?? this.blocState,
      isRememberMe: isRememberMe ?? this.isRememberMe,
    );
  }
}

