// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryResponse _$SummaryResponseFromJson(Map<String, dynamic> json) =>
    SummaryResponse(
      flightSummaryPnrResult: json['flightSummaryPnrResult'] == null
          ? null
          : FlightSummaryPnrResult.fromJson(
              json['flightSummaryPnrResult'] as Map<String, dynamic>),
      orderId: json['orderId'] as num?,
      verifyExpiredDateTime: json['verifyExpiredDateTime'] == null
          ? null
          : DateTime.parse(json['verifyExpiredDateTime'] as String),
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$SummaryResponseToJson(SummaryResponse instance) =>
    <String, dynamic>{
      'flightSummaryPnrResult': instance.flightSummaryPnrResult,
      'orderId': instance.orderId,
      'verifyExpiredDateTime':
          instance.verifyExpiredDateTime?.toIso8601String(),
      'success': instance.success,
    };

FlightSummaryPnrResult _$FlightSummaryPnrResultFromJson(
        Map<String, dynamic> json) =>
    FlightSummaryPnrResult(
      summarySuccess: json['summarySuccess'] as bool?,
      summaryAmount: json['summaryAmount'] as num?,
      currency: json['currency'] as String?,
      session: json['session'] as String?,
    );

Map<String, dynamic> _$FlightSummaryPnrResultToJson(
        FlightSummaryPnrResult instance) =>
    <String, dynamic>{
      'summarySuccess': instance.summarySuccess,
      'summaryAmount': instance.summaryAmount,
      'currency': instance.currency,
      'session': instance.session,
    };
