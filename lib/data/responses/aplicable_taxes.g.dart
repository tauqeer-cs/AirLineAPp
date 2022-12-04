// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aplicable_taxes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicableTaxes _$ApplicableTaxesFromJson(Map<String, dynamic> json) =>
    ApplicableTaxes(
      taxId: json['taxId'] as num?,
      codeType: json['codeType'] as String?,
      taxCode: json['taxCode'] as String?,
      taxDescription: json['taxDescription'] as String?,
      taxType: json['taxType'] as String?,
      taxAmount: json['taxAmount'] as num?,
      taxCurrenyCode: json['taxCurrenyCode'] as String?,
      amountToApply: json['amountToApply'] as num?,
      taxAmountType: json['taxAmountType'] as String?,
      isDefault: json['isDefault'] as bool?,
      taxActive: json['taxActive'] as bool?,
      minAmount: json['minAmount'] as num?,
      maxAmount: json['maxAmount'] as num?,
      originalAmount: json['originalAmount'] as num?,
      originalCurrency: json['originalCurrency'] as String?,
      exchangeRate: json['exchangeRate'] as num?,
      exchangeRateDate: json['exchangeRateDate'] == null
          ? null
          : DateTime.parse(json['exchangeRateDate'] as String),
    );

Map<String, dynamic> _$ApplicableTaxesToJson(ApplicableTaxes instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('taxId', instance.taxId);
  writeNotNull('codeType', instance.codeType);
  writeNotNull('taxCode', instance.taxCode);
  writeNotNull('taxDescription', instance.taxDescription);
  writeNotNull('taxType', instance.taxType);
  writeNotNull('taxAmount', instance.taxAmount);
  writeNotNull('taxCurrenyCode', instance.taxCurrenyCode);
  writeNotNull('amountToApply', instance.amountToApply);
  writeNotNull('taxAmountType', instance.taxAmountType);
  writeNotNull('isDefault', instance.isDefault);
  writeNotNull('taxActive', instance.taxActive);
  writeNotNull('minAmount', instance.minAmount);
  writeNotNull('maxAmount', instance.maxAmount);
  writeNotNull('originalAmount', instance.originalAmount);
  writeNotNull('originalCurrency', instance.originalCurrency);
  writeNotNull('exchangeRate', instance.exchangeRate);
  writeNotNull(
      'exchangeRateDate', instance.exchangeRateDate?.toIso8601String());
  return val;
}
