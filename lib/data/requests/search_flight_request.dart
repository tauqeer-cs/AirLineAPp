import 'package:app/data/requests/verify_request.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_flight_request.g.dart';

@JsonSerializable()
class SearchFlight extends Equatable {
  final CommonFlightRequest? searchFlightRequest;

  const SearchFlight({this.searchFlightRequest});

  factory SearchFlight.fromJson(Map<String, dynamic> json) =>
      _$SearchFlightFromJson(json);

  Map<String, dynamic> toJson() => _$SearchFlightToJson(this);

  //todo currency need to be changed
  factory SearchFlight.fromFilter(FilterState filter) {
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
      promoCode: filter.promoCode,
    );
    return SearchFlight(searchFlightRequest: searchFlightRequest);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [searchFlightRequest];
}

@JsonSerializable(includeIfNull: false)
class CommonFlightRequest extends Equatable {
  @JsonKey(name: 'OriginAirport')
  final String? originAirport;
  @JsonKey(name: 'DestinationAirport')
  final String? destinationAirport;
  @JsonKey(name: 'DepartDate')
  final String? departDate;
  @JsonKey(name: 'ReturnDate')
  final String? returnDate;
  @JsonKey(name: 'Adults')
  final int? adults;
  @JsonKey(name: 'Childrens')
  final int? childrens;
  @JsonKey(name: 'Infants')
  final int? infants;
  @JsonKey(name: 'IsReturn')
  final bool? isReturn;
  @JsonKey(name: 'TripType')
  final String? tripType;
  @JsonKey(name: 'Currency')
  final String? currency;
  @JsonKey(name: 'OutboundFares')
  final List<OutboundFares> outboundFares;
  @JsonKey(name: 'InboundFares')
  final List<OutboundFares> inboundFares;
  @JsonKey(name: 'TotalAmount')
  final num? totalAmount;
  @JsonKey(name: 'PromoCode')
  final String? promoCode;

  @JsonKey(name: 'OutboundLFID')
  final List<int>? outboundLFID;

  @JsonKey(name: 'InboundLFID')
  final List<int>? inboundLFID;

  const CommonFlightRequest(
      {this.originAirport,
      this.destinationAirport,
      this.departDate,
      this.returnDate,
      this.adults,
      this.childrens,
      this.infants,
      this.isReturn,
      this.tripType,
      this.currency,
      this.outboundFares = const [],
      this.inboundFares = const [],
      this.totalAmount,
      this.promoCode,
      this.outboundLFID,
      this.inboundLFID});

  factory CommonFlightRequest.fromJson(Map<String, dynamic> json) =>
      _$CommonFlightRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommonFlightRequestToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        originAirport,
        destinationAirport,
        departDate,
        returnDate,
        adults,
        childrens,
        infants,
        isReturn,
        tripType,
        currency,
        outboundFares,
        inboundFares,
        totalAmount,
        promoCode,
        outboundLFID,
        inboundLFID
      ];
}
