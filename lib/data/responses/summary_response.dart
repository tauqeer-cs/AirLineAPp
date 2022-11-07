import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_response.g.dart';

@JsonSerializable()
class SummaryResponse extends Equatable{
  const SummaryResponse({
    this.flightSummaryPnrResult,
    this.orderId,
    this.verifyExpiredDateTime,
    this.success,
  });

  final FlightSummaryPnrResult? flightSummaryPnrResult;
  final num? orderId;
  final DateTime? verifyExpiredDateTime;
  final bool? success;

  factory SummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$SummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryResponseToJson(this);

  @override
  List<Object?> get props => [
    flightSummaryPnrResult,
    orderId,
    verifyExpiredDateTime,
    success,
  ];
  
  SummaryResponse copyWith({
    FlightSummaryPnrResult? flightSummaryPnrResult,
    num? orderId,
    DateTime? verifyExpiredDateTime,
    bool? success,
  }) =>
      SummaryResponse(
        flightSummaryPnrResult:
            flightSummaryPnrResult ?? this.flightSummaryPnrResult,
        orderId: orderId ?? this.orderId,
        verifyExpiredDateTime:
            verifyExpiredDateTime ?? this.verifyExpiredDateTime,
        success: success ?? this.success,
      );
}

@JsonSerializable()
class FlightSummaryPnrResult extends Equatable{
  const FlightSummaryPnrResult({
    this.summarySuccess,
    this.summaryAmount,
    this.currency,
    this.session,
  });

  factory FlightSummaryPnrResult.fromJson(Map<String, dynamic> json) =>
      _$FlightSummaryPnrResultFromJson(json);

  Map<String, dynamic> toJson() => _$FlightSummaryPnrResultToJson(this);

  @override
  List<Object?> get props => [
    summarySuccess,
    summaryAmount,
    currency,
    session,
  ];
  
  final bool? summarySuccess;
  final num? summaryAmount;
  final String? currency;
  final String? session;

  FlightSummaryPnrResult copyWith({
    bool? summarySuccess,
    num? summaryAmount,
    String? currency,
    String? session,
  }) =>
      FlightSummaryPnrResult(
        summarySuccess: summarySuccess ?? this.summarySuccess,
        summaryAmount: summaryAmount ?? this.summaryAmount,
        currency: currency ?? this.currency,
        session: session ?? this.session,
      );
}
