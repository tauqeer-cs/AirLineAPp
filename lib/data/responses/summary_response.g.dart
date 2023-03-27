// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SummaryResponseCWProxy {
  SummaryResponse flightSummaryPnrResult(
      FlightSummaryPnrResult? flightSummaryPnrResult);

  SummaryResponse fromCache(bool? fromCache);

  SummaryResponse isInvalidMemberID(bool? isInvalidMemberID);

  SummaryResponse isVisaCampaign(bool? isVisaCampaign);

  SummaryResponse orderId(num? orderId);

  SummaryResponse success(bool? success);

  SummaryResponse token(String? token);

  SummaryResponse verifyExpiredDateTime(DateTime? verifyExpiredDateTime);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SummaryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SummaryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SummaryResponse call({
    FlightSummaryPnrResult? flightSummaryPnrResult,
    bool? fromCache,
    bool? isInvalidMemberID,
    bool? isVisaCampaign,
    num? orderId,
    bool? success,
    String? token,
    DateTime? verifyExpiredDateTime,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSummaryResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSummaryResponse.copyWith.fieldName(...)`
class _$SummaryResponseCWProxyImpl implements _$SummaryResponseCWProxy {
  final SummaryResponse _value;

  const _$SummaryResponseCWProxyImpl(this._value);

  @override
  SummaryResponse flightSummaryPnrResult(
          FlightSummaryPnrResult? flightSummaryPnrResult) =>
      this(flightSummaryPnrResult: flightSummaryPnrResult);

  @override
  SummaryResponse fromCache(bool? fromCache) => this(fromCache: fromCache);

  @override
  SummaryResponse isInvalidMemberID(bool? isInvalidMemberID) =>
      this(isInvalidMemberID: isInvalidMemberID);

  @override
  SummaryResponse isVisaCampaign(bool? isVisaCampaign) =>
      this(isVisaCampaign: isVisaCampaign);

  @override
  SummaryResponse orderId(num? orderId) => this(orderId: orderId);

  @override
  SummaryResponse success(bool? success) => this(success: success);

  @override
  SummaryResponse token(String? token) => this(token: token);

  @override
  SummaryResponse verifyExpiredDateTime(DateTime? verifyExpiredDateTime) =>
      this(verifyExpiredDateTime: verifyExpiredDateTime);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SummaryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SummaryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  SummaryResponse call({
    Object? flightSummaryPnrResult = const $CopyWithPlaceholder(),
    Object? fromCache = const $CopyWithPlaceholder(),
    Object? isInvalidMemberID = const $CopyWithPlaceholder(),
    Object? isVisaCampaign = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? success = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
    Object? verifyExpiredDateTime = const $CopyWithPlaceholder(),
  }) {
    return SummaryResponse(
      flightSummaryPnrResult:
          flightSummaryPnrResult == const $CopyWithPlaceholder()
              ? _value.flightSummaryPnrResult
              // ignore: cast_nullable_to_non_nullable
              : flightSummaryPnrResult as FlightSummaryPnrResult?,
      fromCache: fromCache == const $CopyWithPlaceholder()
          ? _value.fromCache
          // ignore: cast_nullable_to_non_nullable
          : fromCache as bool?,
      isInvalidMemberID: isInvalidMemberID == const $CopyWithPlaceholder()
          ? _value.isInvalidMemberID
          // ignore: cast_nullable_to_non_nullable
          : isInvalidMemberID as bool?,
      isVisaCampaign: isVisaCampaign == const $CopyWithPlaceholder()
          ? _value.isVisaCampaign
          // ignore: cast_nullable_to_non_nullable
          : isVisaCampaign as bool?,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as num?,
      success: success == const $CopyWithPlaceholder()
          ? _value.success
          // ignore: cast_nullable_to_non_nullable
          : success as bool?,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
      verifyExpiredDateTime:
          verifyExpiredDateTime == const $CopyWithPlaceholder()
              ? _value.verifyExpiredDateTime
              // ignore: cast_nullable_to_non_nullable
              : verifyExpiredDateTime as DateTime?,
    );
  }
}

extension $SummaryResponseCopyWith on SummaryResponse {
  /// Returns a callable class that can be used as follows: `instanceOfSummaryResponse.copyWith(...)` or like so:`instanceOfSummaryResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SummaryResponseCWProxy get copyWith => _$SummaryResponseCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `SummaryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SummaryResponse(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  SummaryResponse copyWithNull({
    bool flightSummaryPnrResult = false,
    bool fromCache = false,
    bool isInvalidMemberID = false,
    bool isVisaCampaign = false,
    bool orderId = false,
    bool success = false,
    bool token = false,
    bool verifyExpiredDateTime = false,
  }) {
    return SummaryResponse(
      flightSummaryPnrResult:
          flightSummaryPnrResult == true ? null : this.flightSummaryPnrResult,
      fromCache: fromCache == true ? null : this.fromCache,
      isInvalidMemberID:
          isInvalidMemberID == true ? null : this.isInvalidMemberID,
      isVisaCampaign: isVisaCampaign == true ? null : this.isVisaCampaign,
      orderId: orderId == true ? null : this.orderId,
      success: success == true ? null : this.success,
      token: token == true ? null : this.token,
      verifyExpiredDateTime:
          verifyExpiredDateTime == true ? null : this.verifyExpiredDateTime,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryResponse _$SummaryResponseFromJson(Map<String, dynamic> json) =>
    SummaryResponse(
      flightSummaryPnrResult: json['flightSummaryPNRResult'] == null
          ? null
          : FlightSummaryPnrResult.fromJson(
              json['flightSummaryPNRResult'] as Map<String, dynamic>),
      orderId: json['orderId'] as num?,
      verifyExpiredDateTime: json['verifyExpiredDateTime'] == null
          ? null
          : DateTime.parse(json['verifyExpiredDateTime'] as String),
      success: json['success'] as bool?,
      token: json['token'] as String?,
      isInvalidMemberID: json['isInvalidMemberID'] as bool?,
      isVisaCampaign: json['isVisaCampaign'] as bool?,
      fromCache: json['fromCache'] as bool?,
    );

Map<String, dynamic> _$SummaryResponseToJson(SummaryResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('flightSummaryPNRResult', instance.flightSummaryPnrResult);
  writeNotNull('orderId', instance.orderId);
  writeNotNull('verifyExpiredDateTime',
      instance.verifyExpiredDateTime?.toIso8601String());
  writeNotNull('success', instance.success);
  writeNotNull('token', instance.token);
  writeNotNull('isInvalidMemberID', instance.isInvalidMemberID);
  writeNotNull('isVisaCampaign', instance.isVisaCampaign);
  writeNotNull('fromCache', instance.fromCache);
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
