// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherRequestCWProxy {
  VoucherRequest insertVoucher(String? insertVoucher);

  VoucherRequest token(String? token);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherRequest call({
    String? insertVoucher,
    String? token,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVoucherRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVoucherRequest.copyWith.fieldName(...)`
class _$VoucherRequestCWProxyImpl implements _$VoucherRequestCWProxy {
  final VoucherRequest _value;

  const _$VoucherRequestCWProxyImpl(this._value);

  @override
  VoucherRequest insertVoucher(String? insertVoucher) =>
      this(insertVoucher: insertVoucher);

  @override
  VoucherRequest token(String? token) => this(token: token);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherRequest call({
    Object? insertVoucher = const $CopyWithPlaceholder(),
    Object? token = const $CopyWithPlaceholder(),
  }) {
    return VoucherRequest(
      insertVoucher: insertVoucher == const $CopyWithPlaceholder()
          ? _value.insertVoucher
          // ignore: cast_nullable_to_non_nullable
          : insertVoucher as String?,
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String?,
    );
  }
}

extension $VoucherRequestCopyWith on VoucherRequest {
  /// Returns a callable class that can be used as follows: `instanceOfVoucherRequest.copyWith(...)` or like so:`instanceOfVoucherRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherRequestCWProxy get copyWith => _$VoucherRequestCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `VoucherRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherRequest(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  VoucherRequest copyWithNull({
    bool insertVoucher = false,
    bool token = false,
  }) {
    return VoucherRequest(
      insertVoucher: insertVoucher == true ? null : this.insertVoucher,
      token: token == true ? null : this.token,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherRequest _$VoucherRequestFromJson(Map<String, dynamic> json) =>
    VoucherRequest(
      token: json['token'] as String?,
      insertVoucher: json['InsertVoucher'] as String?,
    );

Map<String, dynamic> _$VoucherRequestToJson(VoucherRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('token', instance.token);
  writeNotNull('InsertVoucher', instance.insertVoucher);
  return val;
}
