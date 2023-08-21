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


  SearchFlight copyWith({CommonFlightRequest? searchFlightRequest}) {
    return SearchFlight(
      searchFlightRequest: searchFlightRequest ?? this.searchFlightRequest,
    );
  }

  factory SearchFlight.fromJson(Map<String, dynamic> json) =>
      _$SearchFlightFromJson(json);

  Map<String, dynamic> toJson() => _$SearchFlightToJson(this);

  //todo currency need to be changed
  factory SearchFlight.fromFilter(FilterState filter,String currency) {
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
      promoCode: filter.promoCode ?? '',
    );
    return SearchFlight(searchFlightRequest: searchFlightRequest);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [searchFlightRequest];


}

@JsonSerializable(includeIfNull: false)
class CommonFlightRequest extends Equatable {

  CommonFlightRequest copyWith({
    String? originAirport,
    String? destinationAirport,
    String? departDate,
    String? returnDate,
    int? adults,
    int? childrens,
    int? infants,
    bool? isReturn,
    String? tripType,
    String? currency,
    List<OutboundFares>? outboundFares,
    List<OutboundFares>? inboundFares,
    num? totalAmount,
    String? promoCode,
    List<String>? outboundLFID,
    List<String>? inboundLFID,
  }) {
    return CommonFlightRequest(
      originAirport: originAirport ?? this.originAirport,
      destinationAirport: destinationAirport ?? this.destinationAirport,
      departDate: departDate ?? this.departDate,
      returnDate: returnDate ?? this.returnDate,
      adults: adults ?? this.adults,
      childrens: childrens ?? this.childrens,
      infants: infants ?? this.infants,
      isReturn: isReturn ?? this.isReturn,
      tripType: tripType ?? this.tripType,
      currency: currency ?? this.currency,
      outboundFares: outboundFares ?? this.outboundFares,
      inboundFares: inboundFares ?? this.inboundFares,
      totalAmount: totalAmount ?? this.totalAmount,
      promoCode: promoCode ?? this.promoCode,
      outboundLFID: outboundLFID ?? this.outboundLFID,
      inboundLFID: inboundLFID ?? this.inboundLFID,
    );
  }

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
  @JsonKey(name: 'promoCode')
  final String promoCode;

  @JsonKey(name: 'OutboundLFID')
  final List<String>? outboundLFID;

  @JsonKey(name: 'InboundLFID')
  final List<String>? inboundLFID;

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
      this.promoCode = '',
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
