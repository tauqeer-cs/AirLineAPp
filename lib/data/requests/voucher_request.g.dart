// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherRequestCWProxy {
  VoucherRequest insertVoucher(String? insertVoucher);

  VoucherRequest token(String? token);

  VoucherRequest voucherPins(List<InsertVoucherPIN> voucherPins);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherRequest call({
    String? insertVoucher,
    String? token,
    List<InsertVoucherPIN>? voucherPins,
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
  VoucherRequest voucherPins(List<InsertVoucherPIN> voucherPins) =>
      this(voucherPins: voucherPins);

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
    Object? voucherPins = const $CopyWithPlaceholder(),
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
      voucherPins:
          voucherPins == const $CopyWithPlaceholder() || voucherPins == null
              ? _value.voucherPins
              // ignore: cast_nullable_to_non_nullable
              : voucherPins as List<InsertVoucherPIN>,
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
      voucherPins: voucherPins,
    );
  }
}

abstract class _$InsertVoucherPINCWProxy {
  InsertVoucherPIN voucherCode(String? voucherCode);

  InsertVoucherPIN voucherPin(String? voucherPin);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertVoucherPIN(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertVoucherPIN(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertVoucherPIN call({
    String? voucherCode,
    String? voucherPin,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfInsertVoucherPIN.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfInsertVoucherPIN.copyWith.fieldName(...)`
class _$InsertVoucherPINCWProxyImpl implements _$InsertVoucherPINCWProxy {
  final InsertVoucherPIN _value;

  const _$InsertVoucherPINCWProxyImpl(this._value);

  @override
  InsertVoucherPIN voucherCode(String? voucherCode) =>
      this(voucherCode: voucherCode);

  @override
  InsertVoucherPIN voucherPin(String? voucherPin) =>
      this(voucherPin: voucherPin);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `InsertVoucherPIN(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertVoucherPIN(...).copyWith(id: 12, name: "My name")
  /// ````
  InsertVoucherPIN call({
    Object? voucherCode = const $CopyWithPlaceholder(),
    Object? voucherPin = const $CopyWithPlaceholder(),
  }) {
    return InsertVoucherPIN(
      voucherCode: voucherCode == const $CopyWithPlaceholder()
          ? _value.voucherCode
          // ignore: cast_nullable_to_non_nullable
          : voucherCode as String?,

    );
  }
}

extension $InsertVoucherPINCopyWith on InsertVoucherPIN {
  /// Returns a callable class that can be used as follows: `instanceOfInsertVoucherPIN.copyWith(...)` or like so:`instanceOfInsertVoucherPIN.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$InsertVoucherPINCWProxy get copyWith => _$InsertVoucherPINCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `InsertVoucherPIN(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// InsertVoucherPIN(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  InsertVoucherPIN copyWithNull({
    bool voucherCode = false,
    bool voucherPin = false,
  }) {
    return InsertVoucherPIN(
      voucherCode: voucherCode == true ? null : this.voucherCode,
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
      voucherPins: (json['InsertVoucherPIN'] as List<dynamic>?)
              ?.map((e) => InsertVoucherPIN.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
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
  val['InsertVoucherPIN'] = instance.voucherPins;
  return val;
}

InsertVoucherPIN _$InsertVoucherPINFromJson(Map<String, dynamic> json) =>
    InsertVoucherPIN(
      voucherCode: json['VoucherCode'] as String?,
    );

Map<String, dynamic> _$InsertVoucherPINToJson(InsertVoucherPIN instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('VoucherCode', instance.voucherCode);
  return val;
}
