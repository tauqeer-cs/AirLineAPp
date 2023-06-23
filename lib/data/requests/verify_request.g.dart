// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyRequest _$VerifyRequestFromJson(Map<String, dynamic> json) =>
    VerifyRequest(
      flightVerifyRequest: json['flightVerifyRequest'] == null
          ? null
          : CommonFlightRequest.fromJson(
              json['flightVerifyRequest'] as Map<String, dynamic>),
      flightSummaryPnrRequest: json['flightSummaryPnrRequest'] == null
          ? null
          : FlightSummaryPnrRequest.fromJson(
              json['flightSummaryPnrRequest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerifyRequestToJson(VerifyRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flightVerifyRequest', instance.flightVerifyRequest);
  writeNotNull('flightSummaryPnrRequest', instance.flightSummaryPnrRequest);
  return val;
}

OutboundFares _$OutboundFaresFromJson(Map<String, dynamic> json) =>
    OutboundFares(
      lfid: json['LFID'],
      fbCode: json['FBCode'] as String?,
    );

Map<String, dynamic> _$OutboundFaresToJson(OutboundFares instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('LFID', instance.lfid);
  writeNotNull('FBCode', instance.fbCode);
  return val;
}
