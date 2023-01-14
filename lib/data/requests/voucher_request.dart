import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voucher_request.g.dart';

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class VoucherRequest extends Equatable {
  const VoucherRequest({
    this.token,
    this.insertVoucher,
    this.voucherPins = const [],
  });

  final String? token;
  @JsonKey(name: 'InsertVoucher')
  final String? insertVoucher;
  @JsonKey(name: 'InsertVoucherPIN')
  final List<InsertVoucherPIN> voucherPins;

  factory VoucherRequest.fromJson(Map<String, dynamic> json) =>
      _$VoucherRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VoucherRequestToJson(this);

  @override
  List<Object?> get props => [token, insertVoucher, voucherPins];
}

@CopyWith(copyWithNull: true)
@JsonSerializable(includeIfNull: false)
class InsertVoucherPIN extends Equatable {
  const InsertVoucherPIN({
    this.voucherCode,
    this.voucherPin,
  });

  @JsonKey(name: 'VoucherCode')
  final String? voucherCode;
  @JsonKey(name: 'VoucherPin')
  final String? voucherPin;

  factory InsertVoucherPIN.fromJson(Map<String, dynamic> json) =>
      _$InsertVoucherPINFromJson(json);

  Map<String, dynamic> toJson() => _$InsertVoucherPINToJson(this);

  @override
  List<Object?> get props => [voucherCode, voucherPin];
}
