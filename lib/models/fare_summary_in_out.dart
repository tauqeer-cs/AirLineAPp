import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fare_summary_in_out.g.dart';

@JsonSerializable()
class FareSummaryInOut extends Equatable {
  FareSummaryInOut({
    this.outboundBookingSummary,
    this.inboundBookingSummary,
  });

  final BoundBookingSummary? outboundBookingSummary;
  final BoundBookingSummary? inboundBookingSummary;

  @override
  List<Object?> get props => [
        this.outboundBookingSummary,
        this.inboundBookingSummary,
      ];

  factory FareSummaryInOut.fromJson(Map<String, dynamic> json) =>
      _$FareSummaryInOutFromJson(json);

  Map<String, dynamic> toJson() => _$FareSummaryInOutToJson(this);
}

@JsonSerializable()
class BoundBookingSummary extends Equatable {
  @override
  List<Object?> get props => [
        this.fareAndTax,
        this.seat,
        this.meal,
        this.baggage,
        this.bundle,
        this.insurance,
        this.specialAddOn,
      ];

  BoundBookingSummary({
    this.fareAndTax,
    this.seat,
    this.meal,
    this.baggage,
    this.bundle,
    this.insurance,
    this.specialAddOn,
  });

  final ItemConfirmation? fareAndTax;
  final ItemConfirmation? seat;
  final ItemConfirmation? meal;
  final ItemConfirmation? baggage;
  final ItemConfirmation? bundle;
  final ItemConfirmation? insurance;
  final ItemConfirmation? specialAddOn;

  factory BoundBookingSummary.fromJson(Map<String, dynamic> json) =>
      _$BoundBookingSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$BoundBookingSummaryToJson(this);
}

@JsonSerializable()
class ItemConfirmation extends Equatable {
  @override
  List<Object?> get props => [
        this.totalAmount,
        this.currency,
        this.itemList,
      ];

  ItemConfirmation({
    this.totalAmount,
    this.currency,
    this.itemList,
  });

  final double? totalAmount;
  final String? currency;
  final List<ItemList>? itemList;

  factory ItemConfirmation.fromJson(Map<String, dynamic> json) =>
      _$ItemConfirmationFromJson(json);

  Map<String, dynamic> toJson() => _$ItemConfirmationToJson(this);
}

@JsonSerializable()
class ItemList extends Equatable {
  @override
  List<Object?> get props => [
        this.name,
        this.currency,
        this.amount,
        this.totalAmount,
        this.quantity,
      ];

  ItemList({
    this.name,
    this.currency,
    this.amount,
    this.totalAmount,
    this.quantity,
  });

  final String? name;
  final String? currency;
  final double? amount;
  final double? totalAmount;
  final int? quantity;

  factory ItemList.fromJson(Map<String, dynamic> json) =>
      _$ItemListFromJson(json);

  Map<String, dynamic> toJson() => _$ItemListToJson(this);
}
