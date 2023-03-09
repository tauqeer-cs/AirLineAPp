class ValidatorUtils {
  static String? checkTwoField(String? value, String? comparator,
      {String? errorText}) {
    final isSame = value == comparator;
    return isSame ? null : errorText ?? "Confirm password not match with password";
  }

  static bool isValidEmail(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }


}

