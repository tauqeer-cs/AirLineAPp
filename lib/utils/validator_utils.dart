class ValidatorUtils {
  static String? checkTwoField(String? value, String? comparator,
      {String? errorText}) {
    final isSame = value == comparator;
    return isSame ? null : errorText ?? "Confirm password not match with password";
  }
}
