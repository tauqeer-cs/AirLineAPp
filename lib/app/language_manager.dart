class LanguageManager {
  static final LanguageManager _instance = LanguageManager._internal();

  factory LanguageManager() {
    return _instance;
  }

  LanguageManager._internal();

  String _currentLanguage = 'en_US';

  String get currentLanguage => _currentLanguage;

  void setLanguage(String language) {
    if(language == 'th') {
      language = 'th-TH';
    }
    else {
      language = 'en_US';
    }
    _currentLanguage = language;
  }
}
