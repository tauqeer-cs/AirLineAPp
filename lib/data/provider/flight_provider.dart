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
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../requests/token_request.dart';
import '../responses/promotions_response.dart';


part 'flight_provider.g.dart';

@RestApi()
abstract class FlightProvider {
  factory FlightProvider(Dio dio, {String baseUrl}) = _FlightProvider;
  @GET('flight/getairport')
  Future<AirportsResponse> getAirports();

  @POST('flight/searchflight')
  Future<FlightResponse> searchFlight(@Body() SearchFlight searchFlight);

  @POST('flight/searchdaterange')
  Future<SearchDateRange> searchFlightDateRange(@Body() SearchFlight searchFlight);

  @POST('checkout/verifyflight')
  Future<VerifyResponse> verifyFlightProv(@Body() VerifyRequest verifyRequest);

  @POST('checkout/reverifyflight')
  Future<VerifyResponse> reVerifyFlight(@Body() VerifyRequest verifyRequest);

  @POST('checkout/reverifypnr')
  Future<ReverifyPnrResponse> reverifyPnr(@Body() ReverifyPnrRequest verifyRequest);

  @POST('checkout/summaryflight')
  Future<SummaryResponse> summaryFlight(@Body() SummaryRequest summaryRequest);

  @POST('checkout/updateinsuranceflight')
  Future<SummaryResponse> updateInsurance(@Body() InsuranceRequest insuranceRequest);

  @POST('checkout/bookflight')
  Future<PayRedirectionValue> bookFlightProvider(@Body() BookRequest bookRequest);

  @GET('checkout/flightbookingdetail')
  Future<ConfirmationModel> bookingDetail(@Query("superPNRNo") String key);

  @POST('checkout/addvoucherflight')
  Future<VoucherResponse> addVoucher(@Body() VoucherRequest voucher);

  @POST('checkout/removevoucherflight')
  Future<VoucherResponse> removeVoucher(@Body() VoucherRequest voucher);

  @POST('checkout/getlmsoption')
  Future<PromotionsResponse> getPromotionsData(@Body() Token voucher);

  @POST('checkout/getmmblmsoption')
  Future<PromotionsResponse> getMMBPromotionsData(@Body() Token voucher);

  //api/v1/checkout/


  @POST('checkout/holdlmsoption')
  Future<RedeemPointsResponse> holdLmsOption(@Body() Token voucher);


  @POST('checkout/holdlmsoption')
  Future<PromotionsResponse> setectPromotion(@Body() Token voucher);

//

}
