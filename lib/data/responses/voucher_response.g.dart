// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$VoucherResponseCWProxy {
  VoucherResponse addVoucherResult(AddVoucherResult? addVoucherResult);

  VoucherResponse isInvalidMemberID(bool? isInvalidMemberID);

  VoucherResponse orderID(int? orderID);

  VoucherResponse success(bool? success);

  VoucherResponse verifyExpiredDateTime(DateTime? verifyExpiredDateTime);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherResponse call({
    AddVoucherResult? addVoucherResult,
    bool? isInvalidMemberID,
    int? orderID,
    bool? success,
    DateTime? verifyExpiredDateTime,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVoucherResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVoucherResponse.copyWith.fieldName(...)`
class _$VoucherResponseCWProxyImpl implements _$VoucherResponseCWProxy {
  final VoucherResponse _value;

  const _$VoucherResponseCWProxyImpl(this._value);

  @override
  VoucherResponse addVoucherResult(AddVoucherResult? addVoucherResult) =>
      this(addVoucherResult: addVoucherResult);

  @override
  VoucherResponse isInvalidMemberID(bool? isInvalidMemberID) =>
      this(isInvalidMemberID: isInvalidMemberID);

  @override
  VoucherResponse orderID(int? orderID) => this(orderID: orderID);

  @override
  VoucherResponse success(bool? success) => this(success: success);

  @override
  VoucherResponse verifyExpiredDateTime(DateTime? verifyExpiredDateTime) =>
      this(verifyExpiredDateTime: verifyExpiredDateTime);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherResponse call({
    Object? addVoucherResult = const $CopyWithPlaceholder(),
    Object? isInvalidMemberID = const $CopyWithPlaceholder(),
    Object? orderID = const $CopyWithPlaceholder(),
    Object? success = const $CopyWithPlaceholder(),
    Object? verifyExpiredDateTime = const $CopyWithPlaceholder(),
  }) {
    return VoucherResponse(
      addVoucherResult: addVoucherResult == const $CopyWithPlaceholder()
          ? _value.addVoucherResult
          // ignore: cast_nullable_to_non_nullable
          : addVoucherResult as AddVoucherResult?,
      isInvalidMemberID: isInvalidMemberID == const $CopyWithPlaceholder()
          ? _value.isInvalidMemberID
          // ignore: cast_nullable_to_non_nullable
          : isInvalidMemberID as bool?,
      orderID: orderID == const $CopyWithPlaceholder()
          ? _value.orderID
          // ignore: cast_nullable_to_non_nullable
          : orderID as int?,
      success: success == const $CopyWithPlaceholder()
          ? _value.success
          // ignore: cast_nullable_to_non_nullable
          : success as bool?,
      verifyExpiredDateTime:
          verifyExpiredDateTime == const $CopyWithPlaceholder()
              ? _value.verifyExpiredDateTime
              // ignore: cast_nullable_to_non_nullable
              : verifyExpiredDateTime as DateTime?,
    );
  }
}

extension $VoucherResponseCopyWith on VoucherResponse {
  /// Returns a callable class that can be used as follows: `instanceOfVoucherResponse.copyWith(...)` or like so:`instanceOfVoucherResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherResponseCWProxy get copyWith => _$VoucherResponseCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `VoucherResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherResponse(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  VoucherResponse copyWithNull({
    bool addVoucherResult = false,
    bool isInvalidMemberID = false,
    bool orderID = false,
    bool success = false,
    bool verifyExpiredDateTime = false,
  }) {
    return VoucherResponse(
      addVoucherResult: addVoucherResult == true ? null : this.addVoucherResult,
      isInvalidMemberID:
          isInvalidMemberID == true ? null : this.isInvalidMemberID,
      orderID: orderID == true ? null : this.orderID,
      success: success == true ? null : this.success,
      verifyExpiredDateTime:
          verifyExpiredDateTime == true ? null : this.verifyExpiredDateTime,
    );
  }
}

abstract class _$AddVoucherResultCWProxy {
  AddVoucherResult voucherDiscounts(List<VoucherDiscount>? voucherDiscounts);

  AddVoucherResult voucherTotalDiscountAmount(int? voucherTotalDiscountAmount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddVoucherResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddVoucherResult(...).copyWith(id: 12, name: "My name")
  /// ````
  AddVoucherResult call({
    List<VoucherDiscount>? voucherDiscounts,
    int? voucherTotalDiscountAmount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAddVoucherResult.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAddVoucherResult.copyWith.fieldName(...)`
class _$AddVoucherResultCWProxyImpl implements _$AddVoucherResultCWProxy {
  final AddVoucherResult _value;

  const _$AddVoucherResultCWProxyImpl(this._value);

  @override
  AddVoucherResult voucherDiscounts(List<VoucherDiscount>? voucherDiscounts) =>
      this(voucherDiscounts: voucherDiscounts);

  @override
  AddVoucherResult voucherTotalDiscountAmount(
          int? voucherTotalDiscountAmount) =>
      this(voucherTotalDiscountAmount: voucherTotalDiscountAmount);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AddVoucherResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddVoucherResult(...).copyWith(id: 12, name: "My name")
  /// ````
  AddVoucherResult call({
    Object? voucherDiscounts = const $CopyWithPlaceholder(),
    Object? voucherTotalDiscountAmount = const $CopyWithPlaceholder(),
  }) {
    return AddVoucherResult(
      voucherDiscounts: voucherDiscounts == const $CopyWithPlaceholder()
          ? _value.voucherDiscounts
          // ignore: cast_nullable_to_non_nullable
          : voucherDiscounts as List<VoucherDiscount>?,
      voucherTotalDiscountAmount:
          voucherTotalDiscountAmount == const $CopyWithPlaceholder()
              ? _value.voucherTotalDiscountAmount
              // ignore: cast_nullable_to_non_nullable
              : voucherTotalDiscountAmount as int?,
    );
  }
}

extension $AddVoucherResultCopyWith on AddVoucherResult {
  /// Returns a callable class that can be used as follows: `instanceOfAddVoucherResult.copyWith(...)` or like so:`instanceOfAddVoucherResult.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AddVoucherResultCWProxy get copyWith => _$AddVoucherResultCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `AddVoucherResult(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AddVoucherResult(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  AddVoucherResult copyWithNull({
    bool voucherDiscounts = false,
    bool voucherTotalDiscountAmount = false,
  }) {
    return AddVoucherResult(
      voucherDiscounts: voucherDiscounts == true ? null : this.voucherDiscounts,
      voucherTotalDiscountAmount: voucherTotalDiscountAmount == true
          ? null
          : this.voucherTotalDiscountAmount,
    );
  }
}

abstract class _$VoucherDiscountCWProxy {
  VoucherDiscount currency(String? currency);

  VoucherDiscount discountAmount(int? discountAmount);

  VoucherDiscount reservationPaymentId(int? reservationPaymentId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherDiscount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherDiscount(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherDiscount call({
    String? currency,
    int? discountAmount,
    int? reservationPaymentId,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfVoucherDiscount.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfVoucherDiscount.copyWith.fieldName(...)`
class _$VoucherDiscountCWProxyImpl implements _$VoucherDiscountCWProxy {
  final VoucherDiscount _value;

  const _$VoucherDiscountCWProxyImpl(this._value);

  @override
  VoucherDiscount currency(String? currency) => this(currency: currency);

  @override
  VoucherDiscount discountAmount(int? discountAmount) =>
      this(discountAmount: discountAmount);

  @override
  VoucherDiscount reservationPaymentId(int? reservationPaymentId) =>
      this(reservationPaymentId: reservationPaymentId);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `VoucherDiscount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherDiscount(...).copyWith(id: 12, name: "My name")
  /// ````
  VoucherDiscount call({
    Object? currency = const $CopyWithPlaceholder(),
    Object? discountAmount = const $CopyWithPlaceholder(),
    Object? reservationPaymentId = const $CopyWithPlaceholder(),
  }) {
    return VoucherDiscount(
      currency: currency == const $CopyWithPlaceholder()
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as String?,
      discountAmount: discountAmount == const $CopyWithPlaceholder()
          ? _value.discountAmount
          // ignore: cast_nullable_to_non_nullable
          : discountAmount as int?,
      reservationPaymentId: reservationPaymentId == const $CopyWithPlaceholder()
          ? _value.reservationPaymentId
          // ignore: cast_nullable_to_non_nullable
          : reservationPaymentId as int?,
    );
  }
}

extension $VoucherDiscountCopyWith on VoucherDiscount {
  /// Returns a callable class that can be used as follows: `instanceOfVoucherDiscount.copyWith(...)` or like so:`instanceOfVoucherDiscount.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$VoucherDiscountCWProxy get copyWith => _$VoucherDiscountCWProxyImpl(this);

  /// Copies the object with the specific fields set to `null`. If you pass `false` as a parameter, nothing will be done and it will be ignored. Don't do it. Prefer `copyWith(field: null)` or `VoucherDiscount(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// VoucherDiscount(...).copyWithNull(firstField: true, secondField: true)
  /// ````
  VoucherDiscount copyWithNull({
    bool currency = false,
    bool discountAmount = false,
    bool reservationPaymentId = false,
  }) {
    return VoucherDiscount(
      currency: currency == true ? null : this.currency,
      discountAmount: discountAmount == true ? null : this.discountAmount,
      reservationPaymentId:
          reservationPaymentId == true ? null : this.reservationPaymentId,
    );
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoucherResponse _$VoucherResponseFromJson(Map<String, dynamic> json) =>
    VoucherResponse(
      addVoucherResult: json['addVoucherResult'] == null
          ? null
          : AddVoucherResult.fromJson(
              json['addVoucherResult'] as Map<String, dynamic>),
      orderID: json['orderID'] as int?,
      verifyExpiredDateTime: json['verifyExpiredDateTime'] == null
          ? null
          : DateTime.parse(json['verifyExpiredDateTime'] as String),
      success: json['success'] as bool?,
      isInvalidMemberID: json['isInvalidMemberID'] as bool?,
    );

Map<String, dynamic> _$VoucherResponseToJson(VoucherResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('addVoucherResult', instance.addVoucherResult);
  writeNotNull('orderID', instance.orderID);
  writeNotNull('verifyExpiredDateTime',
      instance.verifyExpiredDateTime?.toIso8601String());
  writeNotNull('success', instance.success);
  writeNotNull('isInvalidMemberID', instance.isInvalidMemberID);
  return val;
}

AddVoucherResult _$AddVoucherResultFromJson(Map<String, dynamic> json) =>
    AddVoucherResult(
      voucherDiscounts: (json['voucherDiscounts'] as List<dynamic>?)
          ?.map((e) => VoucherDiscount.fromJson(e as Map<String, dynamic>))
          .toList(),
      voucherTotalDiscountAmount: json['voucherTotalDiscountAmount'] as int?,
    );

Map<String, dynamic> _$AddVoucherResultToJson(AddVoucherResult instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('voucherDiscounts', instance.voucherDiscounts);
  writeNotNull(
      'voucherTotalDiscountAmount', instance.voucherTotalDiscountAmount);
  return val;
}

VoucherDiscount _$VoucherDiscountFromJson(Map<String, dynamic> json) =>
    VoucherDiscount(
      reservationPaymentId: json['reservationPaymentId'] as int?,
      discountAmount: json['discountAmount'] as int?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$VoucherDiscountToJson(VoucherDiscount instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('reservationPaymentId', instance.reservationPaymentId);
  writeNotNull('discountAmount', instance.discountAmount);
  writeNotNull('currency', instance.currency);
  return val;
}
