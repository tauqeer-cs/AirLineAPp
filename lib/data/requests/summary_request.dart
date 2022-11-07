import 'package:app/data/requests/flight_summary_pnr_request.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_request.g.dart';

@JsonSerializable()
class SummaryRequest extends Equatable{
  final FlightSummaryPnrRequest flightSummaryPNRRequest;
  final String token;

  const SummaryRequest({required this.flightSummaryPNRRequest, required this.token});

  factory SummaryRequest.fromJson(Map<String, dynamic> json) =>
      _$SummaryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SummaryRequestToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props =>[flightSummaryPNRRequest, token];
}