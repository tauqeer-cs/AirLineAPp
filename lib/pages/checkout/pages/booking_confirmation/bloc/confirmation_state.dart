part of 'confirmation_cubit.dart';


class ConfirmationState extends Equatable {
  final ConfirmationModel? confirmationModel;
  final BlocState blocState;
  final String message;
  final String bookingStatus;

  final String bookingId;


  const ConfirmationState({
    this.confirmationModel,
    this.blocState = BlocState.initial,
    this.message = '',
    this.bookingStatus = '',
    this.bookingId = '',
  });
  ConfirmationState copyWith({
    BlocState? blocState,
    String? message,
    ConfirmationModel? confirmationModel,
    String? bookingStatus,
    String? bookingId,
  }) {
    return ConfirmationState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      confirmationModel: confirmationModel ?? this.confirmationModel,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingId: bookingId ?? this.bookingId,

    );
  }
  @override
  List<Object?> get props => [confirmationModel, blocState, message,bookingStatus,bookingId];
}

