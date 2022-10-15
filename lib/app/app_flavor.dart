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
        return 'MyAirline - Staging';
      default:
        return 'MyAirline';
    }
  }


  static String get paymentRedirectUrl {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://mya-booking.alphareds.com/booked';
      default:
        return 'https://mya-booking.alphareds.com/booked';
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
