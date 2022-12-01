part of 'booking_cubit.dart';

@CopyWith(copyWithNull: true)
class BookingState extends Equatable {
  final BlocState blocState;
  final String message;
  final String? superPnrNo;

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
    this.superPnrNo,
    this.selectedReturn,
    this.isVerify = false,
    this.verifyResponse,
    this.departureColorMapping,
    this.returnColorMapping,
    this.summaryRequest,
  });

  num get getFinalPrice => num.parse(((selectedDeparture?.getTotalPrice ?? 0) +
          (selectedReturn?.getTotalPrice ?? 0))
      .toStringAsFixed(2));

  num get getFinalPriceDisplay =>
      num.parse(((selectedDeparture?.getTotalPriceDisplay ?? 0) +
              (selectedReturn?.getTotalPriceDisplay ?? 0))
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
        superPnrNo,
      ];
}
