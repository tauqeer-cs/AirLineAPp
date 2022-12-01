// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverify_pnr_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReverifyPnrResponseCWProxy {
  ReverifyPnrResponse message(String? message);

  ReverifyPnrResponse result(Result? result);

  ReverifyPnrResponse success(bool? success);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReverifyPnrResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReverifyPnrResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ReverifyPnrResponse call({
    String? message,
    Result? result,
    bool? success,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReverifyPnrResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReverifyPnrResponse.copyWith.fieldName(...)`
class _$ReverifyPnrResponseCWProxyImpl implements _$ReverifyPnrResponseCWProxy {
  final ReverifyPnrResponse _value;

  const _$ReverifyPnrResponseCWProxyImpl(this._value);

  @override
  ReverifyPnrResponse message(String? message) => this(message: message);

  @override
  ReverifyPnrResponse result(Result? result) => this(result: result);

  @override
  ReverifyPnrResponse success(bool? success) => this(success: success);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReverifyPnrResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReverifyPnrResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ReverifyPnrResponse call({
    Object? message = const $CopyWithPlaceholder(),
    Object? result = const $CopyWithPlaceholder(),
    Object? success = const $CopyWithPlaceholder(),
  }) {
    return ReverifyPnrResponse(
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
      result: result == const $CopyWithPlaceholder()
          ? _value.result
          // ignore: cast_nullable_to_non_nullable
          : result as Result?,
      success: success == const $CopyWithPlaceholder()
          ? _value.success
          // ignore: cast_nullable_to_non_nullable
          : success as bool?,
    );
  }
}

extension $ReverifyPnrResponseCopyWith on ReverifyPnrResponse {
  /// Returns a callable class that can be used as follows: `instanceOfReverifyPnrResponse.copyWith(...)` or like so:`instanceOfReverifyPnrResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReverifyPnrResponseCWProxy get copyWith =>
      _$ReverifyPnrResponseCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `ReverifyPnrResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReverifyPnrResponse(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  ReverifyPnrResponse copyWithNull({
    bool message = false,
    bool result = false,
    bool success = false,
  }) {
    return ReverifyPnrResponse(
      message: message == true ? null : this.message,
      result: result == true ? null : this.result,
      success: success == true ? null : this.success,
    );
  }
}

abstract class _$ResultCWProxy {
  Result contentTypes(List<dynamic>? contentTypes);

  Result formatters(List<dynamic>? formatters);

  Result statusCode(int? statusCode);

  Result value(Value? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Result(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Result(...).copyWith(id: 12, name: "My name")
  /// ````
  Result call({
    List<dynamic>? contentTypes,
    List<dynamic>? formatters,
    int? statusCode,
    Value? value,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfResult.copyWith.fieldName(...)`
class _$ResultCWProxyImpl implements _$ResultCWProxy {
  final Result _value;

  const _$ResultCWProxyImpl(this._value);

  @override
  Result contentTypes(List<dynamic>? contentTypes) =>
      this(contentTypes: contentTypes);

  @override
  Result formatters(List<dynamic>? formatters) => this(formatters: formatters);

  @override
  Result statusCode(int? statusCode) => this(statusCode: statusCode);

  @override
  Result value(Value? value) => this(value: value);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Result(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Result(...).copyWith(id: 12, name: "My name")
  /// ````
  Result call({
    Object? contentTypes = const $CopyWithPlaceholder(),
    Object? formatters = const $CopyWithPlaceholder(),
    Object? statusCode = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return Result(
      contentTypes: contentTypes == const $CopyWithPlaceholder()
          ? _value.contentTypes
          // ignore: cast_nullable_to_non_nullable
          : contentTypes as List<dynamic>?,
      formatters: formatters == const $CopyWithPlaceholder()
          ? _value.formatters
          // ignore: cast_nullable_to_non_nullable
          : formatters as List<dynamic>?,
      statusCode: statusCode == const $CopyWithPlaceholder()
          ? _value.statusCode
          // ignore: cast_nullable_to_non_nullable
          : statusCode as int?,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as Value?,
    );
  }
}

extension $ResultCopyWith on Result {
  /// Returns a callable class that can be used as follows: `instanceOfResult.copyWith(...)` or like so:`instanceOfResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ResultCWProxy get copyWith => _$ResultCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Result(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Result(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Result copyWithNull({
    bool contentTypes = false,
    bool formatters = false,
    bool statusCode = false,
    bool value = false,
  }) {
    return Result(
      contentTypes: contentTypes == true ? null : this.contentTypes,
      formatters: formatters == true ? null : this.formatters,
      statusCode: statusCode == true ? null : this.statusCode,
      value: value == true ? null : this.value,
    );
  }
}

abstract class _$ValueCWProxy {
  Value fromCache(bool? fromCache);

  Value isInvalidMemberId(bool? isInvalidMemberId);

  Value orderId(int? orderId);

  Value success(bool? success);

  Value superPnrNo(String? superPnrNo);

  Value verifyExpiredDateTime(DateTime? verifyExpiredDateTime);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Value(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Value(...).copyWith(id: 12, name: "My name")
  /// ````
  Value call({
    bool? fromCache,
    bool? isInvalidMemberId,
    int? orderId,
    bool? success,
    String? superPnrNo,
    DateTime? verifyExpiredDateTime,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfValue.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfValue.copyWith.fieldName(...)`
class _$ValueCWProxyImpl implements _$ValueCWProxy {
  final Value _value;

  const _$ValueCWProxyImpl(this._value);

  @override
  Value fromCache(bool? fromCache) => this(fromCache: fromCache);

  @override
  Value isInvalidMemberId(bool? isInvalidMemberId) =>
      this(isInvalidMemberId: isInvalidMemberId);

  @override
  Value orderId(int? orderId) => this(orderId: orderId);

  @override
  Value success(bool? success) => this(success: success);

  @override
  Value superPnrNo(String? superPnrNo) => this(superPnrNo: superPnrNo);

  @override
  Value verifyExpiredDateTime(DateTime? verifyExpiredDateTime) =>
      this(verifyExpiredDateTime: verifyExpiredDateTime);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Value(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Value(...).copyWith(id: 12, name: "My name")
  /// ````
  Value call({
    Object? fromCache = const $CopyWithPlaceholder(),
    Object? isInvalidMemberId = const $CopyWithPlaceholder(),
    Object? orderId = const $CopyWithPlaceholder(),
    Object? success = const $CopyWithPlaceholder(),
    Object? superPnrNo = const $CopyWithPlaceholder(),
    Object? verifyExpiredDateTime = const $CopyWithPlaceholder(),
  }) {
    return Value(
      fromCache: fromCache == const $CopyWithPlaceholder()
          ? _value.fromCache
          // ignore: cast_nullable_to_non_nullable
          : fromCache as bool?,
      isInvalidMemberId: isInvalidMemberId == const $CopyWithPlaceholder()
          ? _value.isInvalidMemberId
          // ignore: cast_nullable_to_non_nullable
          : isInvalidMemberId as bool?,
      orderId: orderId == const $CopyWithPlaceholder()
          ? _value.orderId
          // ignore: cast_nullable_to_non_nullable
          : orderId as int?,
      success: success == const $CopyWithPlaceholder()
          ? _value.success
          // ignore: cast_nullable_to_non_nullable
          : success as bool?,
      superPnrNo: superPnrNo == const $CopyWithPlaceholder()
          ? _value.superPnrNo
          // ignore: cast_nullable_to_non_nullable
          : superPnrNo as String?,
      verifyExpiredDateTime:
          verifyExpiredDateTime == const $CopyWithPlaceholder()
              ? _value.verifyExpiredDateTime
              // ignore: cast_nullable_to_non_nullable
              : verifyExpiredDateTime as DateTime?,
    );
  }
}

extension $ValueCopyWith on Value {
  /// Returns a callable class that can be used as follows: `instanceOfValue.copyWith(...)` or like so:`instanceOfValue.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ValueCWProxy get copyWith => _$ValueCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `Value(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Value(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  Value copyWithNull({
    bool fromCache = false,
    bool isInvalidMemberId = false,
    bool orderId = false,
    bool success = false,
    bool superPnrNo = false,
    bool verifyExpiredDateTime = false,
  }) {
    return Value(
      fromCache: fromCache == true ? null : this.fromCache,
      isInvalidMemberId:
          isInvalidMemberId == true ? null : this.isInvalidMemberId,
      orderId: orderId == true ? null : this.orderId,
      success: success == true ? null : this.success,
      superPnrNo: superPnrNo == true ? null : this.superPnrNo,
      verifyExpiredDateTime:
          verifyExpiredDateTime == true ? null : this.verifyExpiredDateTime,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverifyPnrResponse _$ReverifyPnrResponseFromJson(Map<String, dynamic> json) =>
    ReverifyPnrResponse(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ReverifyPnrResponseToJson(ReverifyPnrResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('result', instance.result);
  writeNotNull('success', instance.success);
  writeNotNull('message', instance.message);
  return val;
}

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      value: json['value'] == null
          ? null
          : Value.fromJson(json['value'] as Map<String, dynamic>),
      formatters: json['formatters'] as List<dynamic>?,
      contentTypes: json['contentTypes'] as List<dynamic>?,
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$ResultToJson(Result instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('value', instance.value);
  writeNotNull('formatters', instance.formatters);
  writeNotNull('contentTypes', instance.contentTypes);
  writeNotNull('statusCode', instance.statusCode);
  return val;
}

Value _$ValueFromJson(Map<String, dynamic> json) => Value(
      superPnrNo: json['superPnrNo'] as String?,
      orderId: json['orderId'] as int?,
      verifyExpiredDateTime: json['verifyExpiredDateTime'] == null
          ? null
          : DateTime.parse(json['verifyExpiredDateTime'] as String),
      success: json['success'] as bool?,
      isInvalidMemberId: json['isInvalidMemberId'] as bool?,
      fromCache: json['fromCache'] as bool?,
    );

Map<String, dynamic> _$ValueToJson(Value instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('superPnrNo', instance.superPnrNo);
  writeNotNull('orderId', instance.orderId);
  writeNotNull('verifyExpiredDateTime',
      instance.verifyExpiredDateTime?.toIso8601String());
  writeNotNull('success', instance.success);
  writeNotNull('isInvalidMemberId', instance.isInvalidMemberId);
  writeNotNull('fromCache', instance.fromCache);
  return val;
}
