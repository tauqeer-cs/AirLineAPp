import 'dart:io';

import 'package:app/app/app_logger.dart';
import 'package:app/models/profile.dart';
import 'package:app/models/user.dart';
import 'package:app/utils/string_utils.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_insider/src/user.dart';

import 'package:flutter_insider/src/identifiers.dart';

class InsiderRepository {
  static final InsiderRepository _instance =
  InsiderRepository._internal();
  bool isLoggedIn = false;
  InsiderRepository._internal();

  factory InsiderRepository() {
    return _instance;
  }

  loginUser(User user) async{
    FlutterInsiderUser? currentUser = FlutterInsider.Instance.getCurrentUser();
    FlutterInsiderIdentifiers identifiers = FlutterInsiderIdentifiers();
    identifiers.addEmail(user.email.nullIfEmpty ?? "none");
    await currentUser?.login(identifiers, insiderIDResult: (insiderID) {
      logger.d("[INSIDER][login][insiderIDResult]:" + insiderID);
      logger.d("identifiers is ${identifiers.identifiers}");
    });
  }

  loginProfile(UserProfile user) async{
    final String defaultLocale = Platform.localeName; // Returns locale string in the form 'en_US'

    FlutterInsiderUser? currentUser = FlutterInsider.Instance.getCurrentUser();
    FlutterInsiderIdentifiers identifiers = FlutterInsiderIdentifiers();
    identifiers.addEmail(user.email.nullIfEmpty ?? "none");
    currentUser?.setName(user.firstName.setNoneIfNullOrEmpty);
    currentUser?.setSurname(user.lastName.setNoneIfNullOrEmpty);
    currentUser?.setAge(user.userAge());
    currentUser?.setGender(user.insiderGender());
    currentUser?.setBirthday(user.dob ?? DateTime.now());
    currentUser?.setLocationOptin(false);
    currentUser?.setLanguage(Platform.localeName.split("_")[0]);
    currentUser?.setLocale(defaultLocale);
    currentUser?.setCustomAttributeWithString("Country", user.country.setNoneIfNullOrEmpty);
    currentUser?.setCustomAttributeWithString("State", user.state.setNoneIfNullOrEmpty);
    currentUser?.setCustomAttributeWithString("City", user.city.setNoneIfNullOrEmpty);
    await currentUser?.login(identifiers, insiderIDResult: (insiderID) async{
      logger.d('[INSIDER][login][insiderIDResult]: $insiderID');
      final map = await identifiers.getIdentifiers();
      logger.d("identifiers is $map");
    });
    isLoggedIn = true;
  }

  logoutUser() async{
    FlutterInsiderUser? currentUser = FlutterInsider.Instance.getCurrentUser();
    currentUser?.logout();
    isLoggedIn = false;

  }
}