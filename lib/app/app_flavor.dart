enum Flavor {
  staging,
  production,
}

/// The flavor to handle different kind of environment dev, staging, production
class AppFlavor {
  static Flavor appFlavor = Flavor.staging;

  static String get title {
    switch (appFlavor) {
      case Flavor.staging:
        return '1Tplus - Staging';
      default:
        return '1Tplus';
    }
  }

  static String get baseUrlCMS {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://mya-cms.alphareds.com/';
      default:
        return 'https://mya-cms.alphareds.com/';
    }
  }

  static String get baseUrlApi {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://mya-api.alphareds.com/api/';
      default:
        return 'https://mya-api.alphareds.com/api/';
    }
  }
}
