import 'package:app/app/app_flavor.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/flight_provider.dart';
import 'package:app/data/requests/book_request.dart';
import 'package:app/data/requests/reverify_pnr_request.dart';
import 'package:app/data/requests/search_flight_request.dart';
import 'package:app/data/requests/summary_request.dart';
import 'package:app/data/requests/update_insurance_request.dart';
import 'package:app/data/requests/verify_request.dart';
import 'package:app/data/requests/voucher_request.dart';
import 'package:app/data/responses/airports_response.dart';
import 'package:app/data/responses/flight_response.dart';
import 'package:app/data/responses/reverify_pnr_response.dart';
import 'package:app/data/responses/summary_response.dart';
import 'package:app/data/responses/verify_response.dart';
import 'package:app/data/responses/voucher_response.dart';
import 'package:app/models/confirmation_model.dart';
import 'package:app/models/pay_redirection.dart';
import 'package:app/models/search_date_range.dart';

import '../requests/token_request.dart';
import '../responses/promotions_response.dart';

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


  Future<PromotionsResponse> getPromoInfo(Token token) async {
    return await _provider.getPromotionsData(token);
  }

  Future<PromotionsResponse> getPromoInfoMMb(Token token) async {
    return await _provider.getMMBPromotionsData(token);
  }


  Future<RedeemPointsResponse> getRedeemPoints(Token token) async {
    return await _provider.holdLmsOption(token);
  }

  Future<FlightResponse> searchFlightRepo(SearchFlight searchFlight) async {
    return await _provider.searchFlight(searchFlight);
  }

  Future<SearchDateRange> searchFlightDateRangeRepo(SearchFlight searchFlight) async {
    return await _provider.searchFlightDateRange(searchFlight);
  }

  Future<VerifyResponse> verifyFlightRepo(VerifyRequest verifyRequest) async {
    return await _provider.verifyFlightProv(verifyRequest);
  }

  Future<VerifyResponse> reVerifyFlight(VerifyRequest verifyRequest) async {
    return await _provider.reVerifyFlight(verifyRequest);
  }

  Future<ReverifyPnrResponse> reverifyPnr(ReverifyPnrRequest verifyRequest) async {
    return await _provider.reverifyPnr(verifyRequest);
  }

  Future<SummaryResponse> summaryFlightRepo(SummaryRequest summaryRequest) async {
    return await _provider.summaryFlight(summaryRequest);
  }

  Future<SummaryResponse> updateInsurance(InsuranceRequest insuranceRequest) async {
    return await _provider.updateInsurance(insuranceRequest);
  }

  Future<PayRedirectionValue> bookFlightRepo(BookRequest bookRequest) async {
    return await _provider.bookFlightProvider(bookRequest);
  }

  Future<ConfirmationModel> bookingDetail(String bookingId) async {
    return await _provider.bookingDetail(bookingId);
  }

  Future<VoucherResponse> addVoucher(VoucherRequest voucher) async {
    return await _provider.addVoucher(voucher);
  }

  Future<VoucherResponse> removeVoucher(VoucherRequest voucher) async {
    return await _provider.removeVoucher(voucher);
  }
}
