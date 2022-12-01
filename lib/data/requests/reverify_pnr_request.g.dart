// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reverify_pnr_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ReverifyPnrRequestCWProxy {
  ReverifyPnrRequest superPNRNo(String? superPNRNo);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReverifyPnrRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReverifyPnrRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReverifyPnrRequest call({
    String? superPNRNo,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfReverifyPnrRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfReverifyPnrRequest.copyWith.fieldName(...)`
class _$ReverifyPnrRequestCWProxyImpl implements _$ReverifyPnrRequestCWProxy {
  final ReverifyPnrRequest _value;

  const _$ReverifyPnrRequestCWProxyImpl(this._value);

  @override
  ReverifyPnrRequest superPNRNo(String? superPNRNo) =>
      this(superPNRNo: superPNRNo);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ReverifyPnrRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReverifyPnrRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ReverifyPnrRequest call({
    Object? superPNRNo = const $CopyWithPlaceholder(),
  }) {
    return ReverifyPnrRequest(
      superPNRNo: superPNRNo == const $CopyWithPlaceholder()
          ? _value.superPNRNo
          // ignore: cast_nullable_to_non_nullable
          : superPNRNo as String?,
    );
  }
}

extension $ReverifyPnrRequestCopyWith on ReverifyPnrRequest {
  /// Returns a callable class that can be used as follows: `instanceOfReverifyPnrRequest.copyWith(...)` or like so:`instanceOfReverifyPnrRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ReverifyPnrRequestCWProxy get copyWith =>
      _$ReverifyPnrRequestCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `ReverifyPnrRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ReverifyPnrRequest(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  ReverifyPnrRequest copyWithNull({
    bool superPNRNo = false,
  }) {
    return ReverifyPnrRequest(
      superPNRNo: superPNRNo == true ? null : this.superPNRNo,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReverifyPnrRequest _$ReverifyPnrRequestFromJson(Map<String, dynamic> json) =>
    ReverifyPnrRequest(
      superPNRNo: json['SuperPNRNo'] as String?,
    );

Map<String, dynamic> _$ReverifyPnrRequestToJson(ReverifyPnrRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('SuperPNRNo', instance.superPNRNo);
  return val;
}
