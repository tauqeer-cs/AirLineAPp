import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_response.g.dart';

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class VoucherResponse extends Equatable {
  const VoucherResponse({
    this.addVoucherResult,
    this.orderID,
    this.verifyExpiredDateTime,
    this.success,
    this.isInvalidMemberID,
  });

  final AddVoucherResult? addVoucherResult;
  final int? orderID;
  final DateTime? verifyExpiredDateTime;
  final bool? success;
  final bool? isInvalidMemberID;

  factory VoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$VoucherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        addVoucherResult,
        orderID,
        verifyExpiredDateTime,
        success,
        isInvalidMemberID,
      ];
}

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class AddVoucherResult extends Equatable {
  const AddVoucherResult({
    this.voucherDiscounts,
    this.voucherTotalDiscountAmount,
  });

  final List<VoucherDiscount>? voucherDiscounts;
  final num? voucherTotalDiscountAmount;

  @override
  // TODO: implement props
  List<Object?> get props => [
        voucherDiscounts,
        voucherTotalDiscountAmount,
      ];
  factory AddVoucherResult.fromJson(Map<String, dynamic> json) =>
      _$AddVoucherResultFromJson(json);

  Map<String, dynamic> toJson() => _$AddVoucherResultToJson(this);
}

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class VoucherDiscount {
  VoucherDiscount({
    this.reservationPaymentId,
    this.discountAmount,
    this.currency,
  });

  final num? reservationPaymentId;
  final num? discountAmount;
  final String? currency;

  factory VoucherDiscount.fromJson(Map<String, dynamic> json) =>
      _$VoucherDiscountFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherDiscountToJson(this);
}
