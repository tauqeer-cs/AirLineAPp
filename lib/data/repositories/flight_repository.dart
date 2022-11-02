import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/flight_provider.dart';
import 'package:app/data/requests/book_request.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/data/requests/verify_request.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/data/responses/airports_response.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/summary_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/data/responses/voucher_response.dart';
import 'package:app/models/confirmation_model.dart';
import 'package:app/models/pay_redirection.dart';
import 'package:app/models/search_date_range.dart';

class FlightRepository {
  static final FlightRepository _instance = FlightRepository._internal();

  static final FlightProvider _provider = FlightProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  factory FlightRepository() {
    return _instance;
  }

  FlightRepository._internal();

  Future<AirportsResponse> getAirports() async {
    return await _provider.getAirports();
  }

  Future<FlightResponse> searchFlight(SearchFlight searchFlight) async {
    return await _provider.searchFlight(searchFlight);
  }

  Future<SearchDateRange> searchFlightDateRange(SearchFlight searchFlight) async {
    return await _provider.searchFlightDateRange(searchFlight);
  }

  Future<VerifyResponse> verifyFlight(VerifyRequest verifyRequest) async {
    return await _provider.verifyFlight(verifyRequest);
  }

  Future<SummaryResponse> summaryFlight(SummaryRequest summaryRequest) async {
    return await _provider.summaryFlight(summaryRequest);
  }

  Future<PayRedirectionValue> bookFlight(BookRequest bookRequest) async {
    return await _provider.bookFlight(bookRequest);
  }

  Future<ConfirmationModel> bookingDetail(String bookingId) async {
    return await _provider.bookingDetail(bookingId);
  }

  Future<VoucherResponse> addVoucher(VoucherRequest voucher) async {
    return await _provider.addVoucher(voucher);
  }
}
