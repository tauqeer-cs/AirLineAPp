import 'package:app/data/requests/oauth_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_provider.g.dart';

const String userBoxName = "user";

@RestApi()
abstract class AuthProvider {
  factory AuthProvider(Dio dio, {String baseUrl}) = _AuthProvider;

  @POST('Public/oauth')
  Future<String> oauthSignIn(@Body() OauthRequest loginRequest);

  @POST('sign-up')
  Future<dynamic> signup(@Body() dynamic signupRequest);
}
