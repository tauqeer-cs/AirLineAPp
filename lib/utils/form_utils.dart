
import 'package:flutter/services.dart';

import '../localizations/localizations_util.dart';

class AppFormUtils{
  static String? getMatchedPassword(String? password, String? confirmPassword){
    if(password!=confirmPassword) return tr.confirmPasswordDifferent;
    return null;
  }
  static String? getMatchedPin(String? password, String? confirmPassword){
    if(password!=confirmPassword) return tr.verifyPinDifferent;
    return null;
  }

  static TextInputFormatter onlyLetter(){
    return FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"));
  }

  static TextInputFormatter onlyNumber(){
    return FilteringTextInputFormatter.allow(RegExp("[0-9]"));
  }

  static TextInputFormatter denyQuestionMark(){
    return FilteringTextInputFormatter.deny(RegExp("\\?"));
  }


}