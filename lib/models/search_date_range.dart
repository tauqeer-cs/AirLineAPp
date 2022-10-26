import 'package:equatable/equatable.dart';
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
  List<Object?> get props => [this.errors,
    this.dateRangePrices,];
}

@JsonSerializable(explicitToJson: true)
class DateRangePrice extends Equatable {
  const DateRangePrice({
    this.price,
    this.date,
  });

  final num? price;
  final DateTime? date;

  DateRangePrice copyWith({
    num? price,
    DateTime? date,
  }) =>
      DateRangePrice(
        price: price ?? this.price,
        date: date ?? this.date,
      );

  factory DateRangePrice.fromJson(Map<String, dynamic> json) =>
      _$DateRangePriceFromJson(json);

  Map<String, dynamic> toJson() => _$DateRangePriceToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [
        this.price,
        this.date,
      ];
}
