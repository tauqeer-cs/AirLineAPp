part of 'booking_cubit.dart';

class BookingState extends Equatable {
  final BlocState blocState;
  final String message;
  final InboundOutboundSegment? selectedDeparture;
  final InboundOutboundSegment? selectedReturn;
  final bool isVerify;
  final VerifyResponse? verifyResponse;
  final Map<num?, Color>? departureColorMapping;
  final Map<num?, Color>? returnColorMapping;
  final SummaryRequest? summaryRequest;

  const BookingState({
    this.blocState = BlocState.initial,
    this.message = '',
    this.selectedDeparture,
    this.selectedReturn,
    this.isVerify = false,
    this.verifyResponse,
    this.departureColorMapping,
    this.returnColorMapping,
    this.summaryRequest,
  });

  BookingState copyWith({
    BlocState? blocState,
    String? message,
    InboundOutboundSegment? selectedDeparture,
    InboundOutboundSegment? selectedReturn,
    bool? isVerify,
    VerifyResponse? verifyResponse,
    Map<num?, Color>? departureColorMapping,
    Map<num?, Color>? returnColorMapping,
    SummaryRequest? summaryRequest,
  }) {
    return BookingState(
      blocState: blocState ?? this.blocState,
      message: message ?? this.message,
      selectedDeparture: selectedDeparture ?? this.selectedDeparture,
      selectedReturn: selectedReturn ?? this.selectedReturn,
      isVerify: isVerify ?? this.isVerify,
      verifyResponse: verifyResponse ?? this.verifyResponse,
      departureColorMapping:
          departureColorMapping ?? this.departureColorMapping,
      returnColorMapping: returnColorMapping ?? this.returnColorMapping,
      summaryRequest: summaryRequest ?? this.summaryRequest,
    );
  }

  num get getFinalPrice => num.parse(((selectedDeparture?.getTotalPrice ?? 0) +
          (selectedReturn?.getTotalPrice ?? 0))
      .toStringAsFixed(2));

  @override
  List<Object?> get props => [
        selectedDeparture,
        blocState,
        message,
        selectedReturn,
        isVerify,
        verifyResponse,
        departureColorMapping,
        returnColorMapping,
        summaryRequest,
      ];
}
