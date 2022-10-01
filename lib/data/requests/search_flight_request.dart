import 'package:app/models/home_content.dart';
import 'package:app/pages/home/bloc/filter_cubit.dart';
import 'package:app/pages/home/ui/filter/search_flight_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_flight_request.g.dart';

@JsonSerializable()
class SearchFlight extends Equatable {
  final SearchFlightRequest? searchFlightRequest;

  const SearchFlight({this.searchFlightRequest});

  factory SearchFlight.fromJson(Map<String, dynamic> json) =>
      _$SearchFlightFromJson(json);

  Map<String, dynamic> toJson() => _$SearchFlightToJson(this);

  //todo currency need to be changed
  factory SearchFlight.fromFilter(FilterState filter) {
    final searchFlightRequest = SearchFlightRequest(
      returnDate:filter.returnDate?.toIso8601String(),
      departDate:filter.departDate?.toIso8601String(),
      adults: filter.numberPerson.numberOfAdult,
      childrens: filter.numberPerson.numberOfChildren,
      infants: filter.numberPerson.numberOfInfant,
      currency: "MYR",
      destinationAirport: filter.destination?.code,
      isReturn: filter.flightType == FlightType.round,
      originAirport: filter.origin?.code,
      tripType: filter.flightType.message,
    );
    return SearchFlight(searchFlightRequest: searchFlightRequest);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [searchFlightRequest];
}

@JsonSerializable()
class SearchFlightRequest extends Equatable {
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

  const SearchFlightRequest({
    this.originAirport,
    this.destinationAirport,
    this.departDate,
    this.returnDate,
    this.adults,
    this.childrens,
    this.infants,
    this.isReturn,
    this.tripType,
    this.currency,
  });

  factory SearchFlightRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchFlightRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SearchFlightRequestToJson(this);

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
      ];
}
