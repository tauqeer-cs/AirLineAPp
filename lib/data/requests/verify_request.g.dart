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
    );

Map<String, dynamic> _$VerifyRequestToJson(VerifyRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flightVerifyRequest', instance.flightVerifyRequest);
  return val;
}
