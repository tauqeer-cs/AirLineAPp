import 'package:app/data/responses/common_response.dart';
import 'package:app/models/country.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/profile.dart';

part 'profile_provider.g.dart';

@RestApi()
abstract class ProfileProvider {
  factory ProfileProvider(Dio dio, {String baseUrl}) = _ProfileProvider;

  @GET('user/userprofile')
  Future<Profile> getProfile();

  @POST('user/user-update')
  Future<CommonResponse> updateUserProfile(@Body() Profile profile);

}