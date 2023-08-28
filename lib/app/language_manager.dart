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
    else if(language == 'id'){
      language = 'id-ID';
    }
    else {
      language = 'en-US';
    }
    _currentLanguage = language;
  }

  static String seeLanguage(String language) {
    if(language == 'th') {
      language = 'th-TH';
    }
    else if(language == 'id'){
      language = 'id-ID';
    }
    else {
      language = 'en-US';
    }
    return language;
  }

}
