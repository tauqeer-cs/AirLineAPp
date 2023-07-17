import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_request.g.dart';

@JsonSerializable(includeIfNull: false)
class VerifyRequest extends Equatable {
  final CommonFlightRequest? flightVerifyRequest;
  final FlightSummaryPnrRequest? flightSummaryPnrRequest;

  const VerifyRequest({
    this.flightVerifyRequest,
    this.flightSummaryPnrRequest,
  });

  factory VerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRequestToJson(this);

  factory VerifyRequest.fromBooking(
    FilterState filter, {
    List<OutboundFares>? inbound,
    List<OutboundFares>? outbound,
    num? totalAmount,
    FlightSummaryPnrRequest? flightSummaryPnrRequest,
      required String currency,
  }) {
    final searchFlightRequest = CommonFlightRequest(
      returnDate: filter.returnDate?.toIso8601String(),
      departDate: filter.departDate?.toIso8601String(),
      adults: filter.numberPerson.numberOfAdult,
      childrens: filter.numberPerson.numberOfChildren,
      infants: filter.numberPerson.numberOfInfant,
      currency: currency,
      destinationAirport: filter.destination?.code,
      isReturn: filter.flightType == FlightType.round,
      originAirport: filter.origin?.code,
      tripType: filter.flightType.message,
      inboundFares: inbound ?? [],
      outboundFares: outbound ?? [],
      totalAmount: totalAmount,
      promoCode: filter.promoCode ?? ''
    );
    return VerifyRequest(
      flightVerifyRequest: searchFlightRequest,
      flightSummaryPnrRequest: flightSummaryPnrRequest,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [flightVerifyRequest];
}

@JsonSerializable(includeIfNull: false)
class OutboundFares {
  OutboundFares({
    this.lfid,
    this.fbCode,
  });

  @JsonKey(name: 'JourneyKey')
  final String? lfid;
  @JsonKey(name: 'FareKey')
  final String? fbCode;

  OutboundFares copyWith({
    String? lfid,
    String? fbCode,
  }) =>
      OutboundFares(
        lfid: lfid ?? this.lfid,
        fbCode: fbCode ?? this.fbCode,
      );

  factory OutboundFares.fromJson(Map<String, dynamic> json) =>
      _$OutboundFaresFromJson(json);

  Map<String, dynamic> toJson() => _$OutboundFaresToJson(this);
}
