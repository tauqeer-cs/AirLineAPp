class StringUtils {
  static String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index < 0 ? 0 : index) +
        newChar +
        oldString.substring(index + 1);
  }

  static String get loremShort =>
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.";

  static String get loremIpsumText =>
      '''Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aeneancommodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdieta, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium.

Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet.''';
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }



  String camelCase() {
    return split(' ').map((e) {
      if (e.contains("(")) {
        return e.split('(').map((e) => e.capitalize()).join('(');
      }
      return e.capitalize();
    }).join(' ');
  }

  String formatCategory() {
    final beforeNonLeadingCapitalLetter = RegExp(r"(?=(?!^)[A-Z])");
    final capitalized = capitalize();
    List<String> strings = capitalized.split(beforeNonLeadingCapitalLetter);
    return strings.join(" ");
  }

  String sensorEmail() {
    final emails = split("@");
    if (emails.isNotEmpty) {
      var address = emails.first;
      address = StringUtils.replaceCharAt(address, 0, "*");
      address = StringUtils.replaceCharAt(address, 1, "*");
      address = StringUtils.replaceCharAt(address, 2, "*");
      address = StringUtils.replaceCharAt(address, 3, "*");
      emails.removeAt(0);
      emails.insert(0, address);

      return emails.join("@");
    }
    return this;
  }

  String sensorName() {
    var name = this;
    for (int i = 2; i < 5 || length < i; i++) {
      name = StringUtils.replaceCharAt(name, name.length - i, "*");
    }
    return name;
  }

  String sensorEmailFront() {
    var name = this;
    for (int i = 0; i < 5 || length < i; i++) {
      name = StringUtils.replaceCharAt(name, i, "*");
    }
    return name;
  }
}

extension StringNullExtension on String? {
  bool get isEmptyOrNull => this?.isEmpty ?? true;

  String? get returnNullIfEmpty => (this?.isEmpty ?? true) ? null : this;

  String? get nullIfEmpty {
    if (this?.isEmpty ?? true) return null;
    return this;
  }

  String get setNoneIfNullOrEmpty{
    return nullIfEmpty ?? "none";
  }
}
