part of 'confirmation_cubit.dart';


class ConfirmationState extends Equatable {
  final ConfirmationModel? confirmationModel;
  final BlocState blocState;
  final String message;

  const ConfirmationState({
    this.confirmationModel,
    this.blocState = BlocState.initial,
    this.message = '',
  });
  ConfirmationState copyWith({
    BlocState? blocState,
    String? message,
    ConfirmationModel? confirmationModel,
  }) {
    return ConfirmationState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      confirmationModel: confirmationModel ?? this.confirmationModel,
    );
  }
  @override
  List<Object?> get props => [confirmationModel, blocState, message];
}

