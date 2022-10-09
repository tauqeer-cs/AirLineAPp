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

Map<String, dynamic> _$SummaryResponseToJson(SummaryResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flightSummaryPnrResult', instance.flightSummaryPnrResult);
  writeNotNull('orderId', instance.orderId);
  writeNotNull('verifyExpiredDateTime',
      instance.verifyExpiredDateTime?.toIso8601String());
  writeNotNull('success', instance.success);
  return val;
}

FlightSummaryPnrResult _$FlightSummaryPnrResultFromJson(
        Map<String, dynamic> json) =>
    FlightSummaryPnrResult(
      summarySuccess: json['summarySuccess'] as bool?,
      summaryAmount: json['summaryAmount'] as num?,
      currency: json['currency'] as String?,
      session: json['session'] as String?,
    );

Map<String, dynamic> _$FlightSummaryPnrResultToJson(
    FlightSummaryPnrResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('summarySuccess', instance.summarySuccess);
  writeNotNull('summaryAmount', instance.summaryAmount);
  writeNotNull('currency', instance.currency);
  writeNotNull('session', instance.session);
  return val;
}
