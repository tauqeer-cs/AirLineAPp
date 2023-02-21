import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../requests/manage_booking_request.dart';

import '../responses/manage_booking_response.dart';

part 'manage_booking_provider.g.dart';

@RestApi()

abstract class ManageBookingProvider {

  factory ManageBookingProvider(Dio dio, {String baseUrl}) = _ManageBookingProvider;


  @GET('checkout/managebookingdetail')
  Future<ManageBookingResponse> getBookingInfo(@Query("pnr") String pnr,@Query("lastname") String lastname);

}