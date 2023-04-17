// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fare_summary_in_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FareSummaryInOut _$FareSummaryInOutFromJson(Map<String, dynamic> json) =>
    FareSummaryInOut(
      outboundBookingSummary: json['outboundBookingSummary'] == null
          ? null
          : BoundBookingSummary.fromJson(
              json['outboundBookingSummary'] as Map<String, dynamic>),
      inboundBookingSummary: json['inboundBookingSummary'] == null
          ? null
          : BoundBookingSummary.fromJson(
              json['inboundBookingSummary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FareSummaryInOutToJson(FareSummaryInOut instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('outboundBookingSummary', instance.outboundBookingSummary);
  writeNotNull('inboundBookingSummary', instance.inboundBookingSummary);
  return val;
}

BoundBookingSummary _$BoundBookingSummaryFromJson(Map<String, dynamic> json) =>
    BoundBookingSummary(
      fareAndTax: json['fareAndTax'] == null
          ? null
          : ItemConfirmation.fromJson(
              json['fareAndTax'] as Map<String, dynamic>),
      seat: json['seat'] == null
          ? null
          : ItemConfirmation.fromJson(json['seat'] as Map<String, dynamic>),
      meal: json['meal'] == null
          ? null
          : ItemConfirmation.fromJson(json['meal'] as Map<String, dynamic>),
      baggage: json['baggage'] == null
          ? null
          : ItemConfirmation.fromJson(json['baggage'] as Map<String, dynamic>),
      bundle: json['bundle'] == null
          ? null
          : ItemConfirmation.fromJson(json['bundle'] as Map<String, dynamic>),
      insurance: json['insurance'] == null
          ? null
          : ItemConfirmation.fromJson(
              json['insurance'] as Map<String, dynamic>),
      specialAddOn: json['specialAddOn'] == null
          ? null
          : ItemConfirmation.fromJson(
              json['specialAddOn'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BoundBookingSummaryToJson(BoundBookingSummary instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fareAndTax', instance.fareAndTax);
  writeNotNull('seat', instance.seat);
  writeNotNull('meal', instance.meal);
  writeNotNull('baggage', instance.baggage);
  writeNotNull('bundle', instance.bundle);
  writeNotNull('insurance', instance.insurance);
  writeNotNull('specialAddOn', instance.specialAddOn);
  return val;
}

ItemConfirmation _$ItemConfirmationFromJson(Map<String, dynamic> json) =>
    ItemConfirmation(
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      itemList: (json['itemList'] as List<dynamic>?)
          ?.map((e) => ItemList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemConfirmationToJson(ItemConfirmation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('currency', instance.currency);
  writeNotNull('itemList', instance.itemList);
  return val;
}

ItemList _$ItemListFromJson(Map<String, dynamic> json) => ItemList(
      name: json['name'] as String?,
      currency: json['currency'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$ItemListToJson(ItemList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('currency', instance.currency);
  writeNotNull('amount', instance.amount);
  writeNotNull('totalAmount', instance.totalAmount);
  writeNotNull('quantity', instance.quantity);
  return val;
}
