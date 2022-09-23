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

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://mos-1tplus.alphareds.com/api/v1/';
      default:
        return 'https://mos-1tplus.alphareds.com/api/v1/';
    }
  }
}
