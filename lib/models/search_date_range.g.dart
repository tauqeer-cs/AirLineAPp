// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_date_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDateRange _$SearchDateRangeFromJson(Map<String, dynamic> json) =>
    SearchDateRange(
      searchDateRangeResponse: json['searchDateRangeResponse'] == null
          ? null
          : SearchDateRangeResponse.fromJson(
              json['searchDateRangeResponse'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchDateRangeToJson(SearchDateRange instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'searchDateRangeResponse', instance.searchDateRangeResponse?.toJson());
  return val;
}

SearchDateRangeResponse _$SearchDateRangeResponseFromJson(
        Map<String, dynamic> json) =>
    SearchDateRangeResponse(
      errors: json['errors'] as List<dynamic>?,
      dateRangePrices: (json['dateRangePrices'] as List<dynamic>?)
          ?.map((e) => DateRangePrice.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchDateRangeResponseToJson(
    SearchDateRangeResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('errors', instance.errors);
  writeNotNull('dateRangePrices',
      instance.dateRangePrices?.map((e) => e.toJson()).toList());
  return val;
}

DateRangePrice _$DateRangePriceFromJson(Map<String, dynamic> json) =>
    DateRangePrice(
      price: json['price'] as num?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$DateRangePriceToJson(DateRangePrice instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('price', instance.price);
  writeNotNull('date', instance.date?.toIso8601String());
  return val;
}
