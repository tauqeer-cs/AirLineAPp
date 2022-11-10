import 'package:app/data/requests/login_request.dart';
import 'package:app/data/requests/oauth_request.dart';
import 'package:app/data/requests/resend_email_request.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_provider.g.dart';

const String userBoxName = "user";

@RestApi()
abstract class AuthProvider {
  factory AuthProvider(Dio dio, {String baseUrl}) = _AuthProvider;

  @POST('user/sign-in')
  Future<User> emailLogin(@Body() LoginRequest loginRequest);

  @POST('Public/oauth')
  Future<User> oauthSignIn(@Body() OauthRequest loginRequest);

  @POST('user/sign-up')
  Future<User> signup(@Body() SignupRequest signupRequest);

  @POST('user/resendverifyemail')
  Future<void> sendEmail(@Body() ResendEmailRequest emailRequest);
}
