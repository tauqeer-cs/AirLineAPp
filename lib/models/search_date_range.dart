import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_date_range.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchDateRange extends Equatable {
  const SearchDateRange({
    this.searchDateRangeResponse,
  });

  final SearchDateRangeResponse? searchDateRangeResponse;

  SearchDateRange copyWith({
    SearchDateRangeResponse? searchDateRangeResponse,
  }) =>
      SearchDateRange(
        searchDateRangeResponse:
            searchDateRangeResponse ?? this.searchDateRangeResponse,
      );

  factory SearchDateRange.fromJson(Map<String, dynamic> json) =>
      _$SearchDateRangeFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDateRangeToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [searchDateRangeResponse];
}

@JsonSerializable(explicitToJson: true)
class SearchDateRangeResponse extends Equatable {
  const SearchDateRangeResponse({
    this.errors,
    this.dateRangePrices,
  });

  final List<dynamic>? errors;
  final List<DateRangePrice>? dateRangePrices;

  SearchDateRangeResponse copyWith({
    List<dynamic>? errors,
    List<DateRangePrice>? dateRangePrices,
  }) =>
      SearchDateRangeResponse(
        errors: errors ?? this.errors,
        dateRangePrices: dateRangePrices ?? this.dateRangePrices,
      );

  factory SearchDateRangeResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDateRangeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDateRangeResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        errors,
        dateRangePrices,
      ];
}

@JsonSerializable(explicitToJson: true)
class DateRangePrice extends Equatable {
  const DateRangePrice({
    this.price,
    this.departPrice,
    this.returnPrice,
    this.date,
  });

  final num? price;
  final num? departPrice;
  final num? returnPrice;

  String get formattedDepartPrice {
    if (departPrice == null) {
      return "0";
    } else if (departPrice! >= 1000) {
      double value = departPrice! / 1000;
      String formattedValue = value.toStringAsFixed(2);
      if (formattedValue.endsWith('.00')) {
        formattedValue = formattedValue.substring(0, formattedValue.length - 3);
      } else if (formattedValue.endsWith('0')) {
        formattedValue = formattedValue.substring(0, formattedValue.length - 1);
      }
      return "$formattedValue K";
    } else {
      return departPrice.toString();
    }
  }


  final DateTime? date;

  DateRangePrice copyWith({
    num? price,
    num? departPrice,
    num? returnPrice,
    DateTime? date,
  }) =>
      DateRangePrice(
        price: price ?? this.price,
        departPrice: departPrice ?? this.departPrice,
        returnPrice: returnPrice ?? this.returnPrice,
        date: date ?? this.date,
      );

  factory DateRangePrice.fromJson(Map<String, dynamic> json) =>
      _$DateRangePriceFromJson(json);

  Map<String, dynamic> toJson() => _$DateRangePriceToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        price,
        date,
      ];
}
