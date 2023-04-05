import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../requests/check_in_request.dart';
import '../requests/get_boarding_pass_request.dart';
import '../responses/check_in_response.dart';
import '../responses/get_boarding_pass_response.dart';

part 'checkin_provider.g.dart';

@RestApi()
abstract class CheckInProvider {
  factory CheckInProvider(Dio dio, {String baseUrl}) = _CheckInProvider;

  @POST('checkout/checkinpassenger')
  Future<CheckInResponse> checkInPassenger(@Body() CheckInRequest request);


  @POST('checkout/getBoardingPass')
  Future<GetBoardingPassResponse> getBoardingPass(@Body() GetBoardingPassRequest request);




}