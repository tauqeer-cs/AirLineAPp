part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final BlocState blocState;
  final String message;
  final InboundOutboundSegment? selectedDeparture;
  final InboundOutboundSegment? selectedReturn;
  final bool isVerify;
  final VerifyResponse? verifyResponse;

  const BookingState({
    this.blocState = BlocState.initial,
    this.message = '',
    this.selectedDeparture,
    this.selectedReturn,
    this.isVerify = false,
    this.verifyResponse,
  });

  BookingState copyWith({
    BlocState? blocState,
    String? message,
    InboundOutboundSegment? selectedDeparture,
    InboundOutboundSegment? selectedReturn,
    bool? isVerify,
    VerifyResponse? verifyResponse,
  }) {
    return BookingState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      selectedDeparture: selectedDeparture ?? this.selectedDeparture,
      selectedReturn: selectedReturn ?? this.selectedReturn,
      isVerify: isVerify ?? this.isVerify,
      verifyResponse: verifyResponse ?? this.verifyResponse,
    );
  }

  num get getFinalPrice =>
      (selectedDeparture?.getTotalPrice ?? 0) +
      (selectedReturn?.getTotalPrice ?? 0);

  @override
  List<Object?> get props => [
        selectedDeparture,
        blocState,
        message,
        selectedReturn,
        isVerify,
        verifyResponse
      ];
}
