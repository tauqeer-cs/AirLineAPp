// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_flight_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchFlight _$SearchFlightFromJson(Map<String, dynamic> json) => SearchFlight(
      searchFlightRequest: json['searchFlightRequest'] == null
          ? null
          : CommonFlightRequest.fromJson(
              json['searchFlightRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchFlightToJson(SearchFlight instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('searchFlightRequest', instance.searchFlightRequest);
  return val;
}

CommonFlightRequest _$CommonFlightRequestFromJson(Map<String, dynamic> json) =>
    CommonFlightRequest(
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
      outboundLFID: (json['OutboundLFID'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      inboundLFID: (json['InboundLFID'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      totalAmount: json['TotalAmount'] as num?,
    );

Map<String, dynamic> _$CommonFlightRequestToJson(CommonFlightRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('OriginAirport', instance.originAirport);
  writeNotNull('DestinationAirport', instance.destinationAirport);
  writeNotNull('DepartDate', instance.departDate);
  writeNotNull('ReturnDate', instance.returnDate);
  writeNotNull('Adults', instance.adults);
  writeNotNull('Childrens', instance.childrens);
  writeNotNull('Infants', instance.infants);
  writeNotNull('IsReturn', instance.isReturn);
  writeNotNull('TripType', instance.tripType);
  writeNotNull('Currency', instance.currency);
  writeNotNull('OutboundLFID', instance.outboundLFID);
  writeNotNull('InboundLFID', instance.inboundLFID);
  writeNotNull('TotalAmount', instance.totalAmount);
  return val;
}
