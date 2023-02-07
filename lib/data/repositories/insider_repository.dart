import 'package:app/models/user.dart';
import 'package:flutter_insider/flutter_insider.dart';
import 'package:flutter_insider/src/user.dart';
import 'package:flutter_insider/src/product.dart';
import 'package:flutter_insider/enum/InsiderGender.dart';
import 'package:flutter_insider/enum/InsiderCallbackAction.dart';
import 'package:flutter_insider/enum/ContentOptimizerDataType.dart';
import 'package:flutter_insider/src/event.dart';
import 'package:flutter_insider/src/identifiers.dart';

class InsiderRepository {
  static final InsiderRepository _instance =
  InsiderRepository._internal();

  InsiderRepository._internal();

  factory InsiderRepository() {
    return _instance;
  }

  loginUser(User user) async{
    FlutterInsiderUser? currentUser = FlutterInsider.Instance.getCurrentUser();
    FlutterInsiderIdentifiers identifiers = FlutterInsiderIdentifiers();
    identifiers.addEmail(user.email ?? "");
    identifiers.addPhoneNumber("+${user.contactNo}");
    identifiers.addUserID(user.uuid ?? "");
    await currentUser?.login(identifiers, insiderIDResult: (insiderID) {
      print("[INSIDER][login][insiderIDResult]:" + insiderID);
    });
  }
}