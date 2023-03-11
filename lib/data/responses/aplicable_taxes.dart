import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'aplicable_taxes.g.dart';

@JsonSerializable(includeIfNull: false)
class ApplicableTaxes extends Equatable {
  const ApplicableTaxes({
    this.taxId,
    this.codeType,
    this.taxCode,
    this.taxDescription,
    this.taxType,
    this.taxAmount,
    this.taxCurrenyCode,
    this.amountToApply,
    this.taxAmountType,
    this.isDefault,
    this.taxActive,
    this.minAmount,
    this.maxAmount,
    this.originalAmount,
    this.originalCurrency,
    this.exchangeRate,
    this.exchangeRateDate,
  });

  final num? taxId;
  final String? codeType;
  final String? taxCode;
  final String? taxDescription;
  final String? taxType;
  final num? taxAmount;
  final String? taxCurrenyCode;
  final num? amountToApply;
  final String? taxAmountType;
  final bool? isDefault;
  final bool? taxActive;
  final num? minAmount;
  final num? maxAmount;
  final num? originalAmount;
  final String? originalCurrency;
  final num? exchangeRate;
  final DateTime? exchangeRateDate;

  @override
  List<Object?> get props => [
        taxId,
        codeType,
        taxCode,
        taxDescription,
        taxType,
        taxAmount,
        taxCurrenyCode,
        amountToApply,
        taxAmountType,
        isDefault,
        taxActive,
        minAmount,
        maxAmount,
        originalAmount,
        originalCurrency,
        exchangeRate,
        exchangeRateDate,
      ];

  factory ApplicableTaxes.fromJson(Map<String, dynamic> json) =>
      _$ApplicableTaxesFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicableTaxesToJson(this);
}
