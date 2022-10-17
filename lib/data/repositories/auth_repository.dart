import 'dart:async';
import 'dart:io';

import 'package:app/app/app_flavor.dart';
import 'package:app/app/app_logger.dart';
import 'package:app/data/api.dart';
import 'package:app/data/provider/auth_provider.dart';
import 'package:app/data/requests/oauth_request.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/fcm_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

const accessTokenKey = "accessToken";
const String userBoxName = "userBox";
const String tokenBoxName = "tokenBox";

class AuthenticationRepository {
  static final AuthenticationRepository _instance =
      AuthenticationRepository._internal();
  final _controller = StreamController<User>();

  final GoogleSignIn _googleSignIn = GoogleSignIn.standard();

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

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    final googleAppUser = await _googleSignIn.signIn();
    final googleAuth = await googleAppUser!.authentication;
    final requests = OauthRequest(
      token: googleAuth.accessToken,
      platform: "GOOGLE",
      fcmToken: FCMNotification.token,
    );
    final response = await _provider.oauthSignIn(requests);
    print("google auth ${response}");
  }

  Future<void> storeAccessToken(String? value) async {
    var box = Hive.box(tokenBoxName);
    logger.i("saved token $value");
    await box.clear();
    box.add(value);
    //return await _storage.write(key: accessTokenKey, value: value);
  }

  Future<String?> getAccessToken() async {
    var box = Hive.box(tokenBoxName);
    var token = box.isNotEmpty ? box.getAt(0) : "";
    //logger.i("loaded user ${user?.toJson()}");
    //String? token = await _storage.read(key: accessTokenKey);
    logger.i("loaded token $token");
    return token;
  }

  Future<void> deleteAccessToken() async {
    var box = Hive.box(tokenBoxName);
    box.clear();
    //return await _storage.delete(key: accessTokenKey);
  }

  void deleteCurrentUser() {
    var box = Hive.box(userBoxName);
    _controller.add(User.empty);
    box.clear();
  }

  void setCurrentUser(User user) async {
    var box = Hive.box(userBoxName);
    logger.i("saved user ${user.toJson()}");
    await box.clear();
    box.add(user);
    _controller.add(user);
  }

  User getCurrentUser() {
    var box = Hive.box(userBoxName);
    var user = box.isNotEmpty ? box.getAt(0) : User.empty;
    logger.i("loaded user ${user?.toJson()}");
    return user;
  }

  void logout() {
    deleteAccessToken();
    deleteCurrentUser();
  }

  void dispose() => _controller.close();
}
