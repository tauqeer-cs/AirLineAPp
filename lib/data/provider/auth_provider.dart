import 'package:app/data/requests/login_request.dart';
import 'package:app/data/requests/oauth_request.dart';
import 'package:app/data/requests/resend_email_request.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/data/responses/common_response.dart';
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

  @GET('token')
  Future<void> checkToken();

  @GET('user/checktoken')
  Future<CommonResponse> checkToken2();


  @POST('user/resendverifyemail')
  Future<void> sendEmail(@Body() ResendEmailRequest emailRequest);

  @POST('user/user-passwordupdate')
  Future<void> updatePassword(
      @Body() UpdatePasswordRequest updatePasswordRequest);

  @POST('user/user-request-password-reset')
  Future<void> requestReset(
      @Body() UpdatePasswordRequest updatePasswordRequest);

  @POST('user/user-validate-password-reset')
  Future<void> validateReset(
      @Body() UpdatePasswordRequest updatePasswordRequest);

  @POST('user/emailvalidation')
  Future<CommonResponse> validateEmail(
      @Body() UpdatePasswordRequest updatePasswordRequest);

  @POST('user/user-reset-password')
  Future<void> resetPassword(
      @Body() UpdatePasswordRequest updatePasswordRequest);

  @POST('user/user-remove-account')
  Future<void> closeAccount(
      @Body() UpdatePasswordRequest updatePasswordRequest);
}
