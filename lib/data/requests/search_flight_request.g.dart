// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_flight_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFlight _$SearchFlightFromJson(Map<String, dynamic> json) => SearchFlight(
      searchFlightRequest: json['searchFlightRequest'] == null
          ? null
          : SearchFlightRequest.fromJson(
              json['searchFlightRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchFlightToJson(SearchFlight instance) =>
    <String, dynamic>{
      'searchFlightRequest': instance.searchFlightRequest,
    };

SearchFlightRequest _$SearchFlightRequestFromJson(Map<String, dynamic> json) =>
    SearchFlightRequest(
      originAirport: json['OriginAirport'] as String?,
      destinationAirport: json['DestinationAirport'] as String?,
      departDate: json['DepartDate'] as String?,
      returnDate: json['ReturnDate'] as String?,
      adults: json['Adults'] as int?,
      childrens: json['Childrens'] as int?,
      infants: json['Infants'] as int?,
      isReturn: json['IsReturn'] as bool?,
      tripType: json['TripType'] as String?,
      currency: json['Currency'] as String?,
    );

Map<String, dynamic> _$SearchFlightRequestToJson(
        SearchFlightRequest instance) =>
    <String, dynamic>{
      'OriginAirport': instance.originAirport,
      'DestinationAirport': instance.destinationAirport,
      'DepartDate': instance.departDate,
      'ReturnDate': instance.returnDate,
      'Adults': instance.adults,
      'Childrens': instance.childrens,
      'Infants': instance.infants,
      'IsReturn': instance.isReturn,
      'TripType': instance.tripType,
      'Currency': instance.currency,
    };
