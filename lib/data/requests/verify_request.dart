import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_request.g.dart';

@JsonSerializable(includeIfNull: false)
class VerifyRequest extends Equatable{
  final CommonFlightRequest? flightVerifyRequest;

  const VerifyRequest({this.flightVerifyRequest});

  factory VerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyRequestToJson(this);

  factory VerifyRequest.fromBooking(FilterState filter,
      {List<int>? inbound, List<int>? outbound, num? totalAmount}) {
    final searchFlightRequest = CommonFlightRequest(
      returnDate: filter.returnDate?.toIso8601String(),
      departDate: filter.departDate?.toIso8601String(),
      adults: filter.numberPerson.numberOfAdult,
      childrens: filter.numberPerson.numberOfChildren,
      infants: filter.numberPerson.numberOfInfant,
      currency: "MYR",
      destinationAirport: filter.destination?.code,
      isReturn: filter.flightType == FlightType.round,
      originAirport: filter.origin?.code,
      tripType: filter.flightType.message,
      inboundLFID: inbound,
      outboundLFID: outbound,
      totalAmount: totalAmount,
    );
    return VerifyRequest(flightVerifyRequest: searchFlightRequest);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [flightVerifyRequest];
}
