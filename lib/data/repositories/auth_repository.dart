import 'dart:async';
import 'dart:io';

import 'package:app/app/app_flavor.dart';
import 'package:app/app/app_logger.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/auth_provider.dart';
import 'package:app/data/repositories/insider_repository.dart';
import 'package:app/data/requests/login_request.dart';
import 'package:app/data/requests/oauth_request.dart';
import 'package:app/data/requests/resend_email_request.dart';
import 'package:app/data/requests/signup_request.dart';
import 'package:app/data/requests/update_password_request.dart';
import 'package:app/data/responses/common_response.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/fcm_notifications.dart';
import 'package:app/utils/security_utils.dart';
import 'package:app/utils/user_insider.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

const accessTokenKey = "accessToken";
const String userBoxName = "userBox";
const String tokenBoxName = "tokenBox";

class AuthenticationRepository {
  static final AuthenticationRepository _instance =
      AuthenticationRepository._internal();
  final _controller = StreamController<User>();

  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();
  final InsiderRepository insiderRepository = InsiderRepository();

  static final AuthProvider _provider = AuthProvider(
    Api.client,
    baseUrl: '${AppFlavor.baseUrlApi}/v1/',
  );

  factory AuthenticationRepository() {
    return _instance;
  }

  String? temporaryToken = "";

  AuthenticationRepository._internal();

  init() {
    _controller.add(getCurrentUser());
  }

  Stream<User> get user async* {
    yield* _controller.stream;
  }

  Future<void> signUp(SignupRequest signupRequest) async{
    await _provider.signup(signupRequest);
    //setCurrentUser(user);
    //storeAccessToken(user.token);
  }

  Future<void> sendEmail(ResendEmailRequest resendEmailRequest) async{
    await _provider.sendEmail(resendEmailRequest);
  }

  Future<void> updatePassword(UpdatePasswordRequest updatePasswordRequest) async{
    await _provider.updatePassword(updatePasswordRequest);
  }

  Future<void> requestReset(UpdatePasswordRequest updatePasswordRequest) async{
    await _provider.requestReset(updatePasswordRequest);
  }

  Future<void> validateReset(UpdatePasswordRequest updatePasswordRequest) async{
    await _provider.validateReset(updatePasswordRequest);
  }

  Future<CommonResponse> validateEmail(UpdatePasswordRequest updatePasswordRequest) async{
    return await _provider.validateEmail(updatePasswordRequest);
  }

  Future<void> resetPassword(UpdatePasswordRequest updatePasswordRequest) async{
    await _provider.resetPassword(updatePasswordRequest);
  }

  Future<void> closeAccount(UpdatePasswordRequest updatePasswordRequest) async{
    await _provider.closeAccount(updatePasswordRequest);
  }

  Future<void> loginWithEmail(LoginRequest loginRequest) async{
    final user = await _provider.emailLogin(loginRequest);
    if(user.isAccountVerified ?? false){
      storeAccessToken(user.token);
      insiderRepository.loginUser(user);
      setCurrentUser(user);
    }else{
      sendEmail(ResendEmailRequest(email: user.email));
      setTemporaryUser(user);
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    final googleAppUser = await _googleSignIn.signIn(

    );
    if(googleAppUser==null) return;
    final googleAuth = await googleAppUser.authentication;
    final requests = OauthRequest(
      token: googleAuth.idToken,
      platform: "GOOGLE",
      fcmToken: FCMNotification.token,
    );
    final response = await _provider.oauthSignIn(requests);
    setCurrentUser(response);
    storeAccessToken(response.token);
  }

  Future<AuthorizationCredentialAppleID> loginWithApple() async {
    final rawNonce = SecurityUtils.generateNonce();
    final nonce = SecurityUtils.sha256ofString(rawNonce);
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    final requests = OauthRequest(
      token: appleCredential.authorizationCode,
      platform: "APPLE",
      fcmToken: FCMNotification.token,
    );
    final response = await _provider.oauthSignIn(requests);
    setCurrentUser(response);
    storeAccessToken(response.token);
    return appleCredential;
  }


  Future<void> storeAccessToken(String? value) async {
    var box = Hive.box<String>(tokenBoxName);
    logger.i("saved token $value");
    await box.clear();
    box.add(value ?? "");
    //return await _storage.write(key: accessTokenKey, value: value);
  }

  Future<String?> getAccessToken() async {
    var box = Hive.box<String>(tokenBoxName);
    var token = box.isNotEmpty ? box.getAt(0) : "";
    //logger.i("loaded user ${user?.toJson()}");
    //String? token = await _storage.read(key: accessTokenKey);
    logger.i("loaded token $token");
    return token;
  }

  Future<void> deleteAccessToken() async {
    var box = Hive.box<String>(tokenBoxName);
    box.clear();
    //return await _storage.delete(key: accessTokenKey);
  }

  void deleteCurrentUser() {
    var box = Hive.box<User>(userBoxName);
    _controller.add(User.empty);
    box.clear();
  }

  void setCurrentUser(User user) async {
    UserInsider.instance.registerStandardEvent(InsiderConstants.loginCompleted);
    var box = Hive.box<User>(userBoxName);
    logger.i("saved user ${user.toJson()}");
    await box.clear();
    box.add(user);
    _controller.add(user);
  }

  void setTemporaryUser(User user) async {
    _controller.add(user);
  }

  User getCurrentUser() {
    var box = Hive.box<User>(userBoxName);
    var user = box.isNotEmpty ? box.getAt(0) : User.empty;
    logger.i("loaded user ${user?.toJson()}");
    return user ?? User.empty;
  }

  void logout() async {
    disconnectGoogleAccount();
    deleteAccessToken();
    deleteCurrentUser();
  }

  Future<void> disconnectGoogleAccount() async {
    if(Platform.isAndroid){
      final isLogin = await _googleSignIn.isSignedIn();
      if(isLogin){
        await _googleSignIn.disconnect();
        await _googleSignIn.signOut();
      }
    }
  }

  void dispose() => _controller.close();
}
