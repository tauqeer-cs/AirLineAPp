import 'package:app/data/requests/flight_summary_pnr_request.dart';

class SummaryRequest {
  final FlightSummaryPnrRequest flightSummaryPNRRequest;
  final String token;

  SummaryRequest({required this.flightSummaryPNRRequest, required this.token});
}