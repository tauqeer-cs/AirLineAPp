// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryRequest _$SummaryRequestFromJson(Map<String, dynamic> json) =>
    SummaryRequest(
      flightSummaryPNRRequest: FlightSummaryPnrRequest.fromJson(
          json['flightSummaryPNRRequest'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$SummaryRequestToJson(SummaryRequest instance) =>
    <String, dynamic>{
      'flightSummaryPNRRequest': instance.flightSummaryPNRRequest,
      'token': instance.token,
    };
