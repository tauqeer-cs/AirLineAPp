
import '../localizations/localizations_util.dart';

class FormUtils{
  static String? getMatchedPassword(String? password, String? confirmPassword){
    if(password!=confirmPassword) return tr.confirmPasswordDifferent;
    return null;
  }
  static String? getMatchedPin(String? password, String? confirmPassword){
    if(password!=confirmPassword) return tr.verifyPinDifferent;
    return null;
  }
}