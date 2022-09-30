import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/dart/messages_all.dart';
import 'app_localization_delegate.dart';
import 'resources/string_resources.dart';

class AppLocalizations with StringResources {
  static LocalizationsDelegate<AppLocalizations> delegate =
      const AppLocalizationsDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;

      return AppLocalizations();
    });
  }

  static AppLocalizations get instance =>
      AppLocalizationsDelegate.instance; // add this
}
