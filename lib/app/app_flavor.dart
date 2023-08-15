import 'dart:io';

import 'package:app/firebase/dev/firebase_options.dart' as staging;
import 'package:app/firebase/uat/firebase_options.dart' as uat;
import 'package:app/firebase_options.dart' as production;

import 'package:firebase_core/firebase_core.dart';

enum Flavor {
  staging,
  uat,
  production,
}

/// The flavor to handle different kind of environment dev, staging, production
class AppFlavor {
  static Flavor appFlavor = Flavor.staging;

  static String get title {
    switch (appFlavor) {
      case Flavor.staging:
        return 'MYAirline - Nav';
      case Flavor.uat:
        return 'MYAirline - UAT';
      default:
        return 'MYAirline';
    }
  }

  static FirebaseOptions get firebaseOptions {
    switch (appFlavor) {
      case Flavor.staging:
        return staging.DefaultFirebaseOptions.currentPlatform;
      case Flavor.uat:
        return uat.DefaultFirebaseOptions.currentPlatform;
      default:
        return production.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static String get paymentRedirectUrl {
    switch (appFlavor) {
      case Flavor.staging:

//        return 'http://uat-nav.web.myairline.my/';

        return 'https://mya-nav-web.alphareds.com/booked';

      case Flavor.uat:

        //https://uat-nav-api.myairline.my/api/v1/flight/getairport
      //  return 'http://uat-nav.web.myairline.my/';
      //https://uat-nav-api.myairline.my/
        return 'https://uat-nav-booking.myairline.my/booked';
      default:
        return 'https://booking.myairline.my/booked';
    }
  }

  static String get websiteUrl {
    switch (appFlavor) {
      case Flavor.staging:
        return 'http://uat-nav.api.myairline.my/';

        return 'https://mya-nav-web.alphareds.com';
      case Flavor.uat:
       // return 'http://uat-nav.api.myairline.my/';

        return 'https://uat-nav.myairline.my';
      default:
        return 'https://www.myairline.my';
    }
  }

  static String get thirdPartyUrl {
    switch (appFlavor) {
      case Flavor.staging:
        return 'http://uat-nav.api.myairline.my/';
        return 'https://mya-nav-booking.alphareds.com';
        //https://mya-nav-booking.alphareds.com
        return 'https://myairline-gcp-cert-ezycommerce.ezyflight.se';
      case Flavor.uat:
        return 'https://myairline-gcp-cert-ezycommerce.ezyflight.se';
      default:
        return 'https://mybooking.myairline.my';
    }
  }

  static String get baseUrlCMS {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://mya-cms.alphareds.com/';
      case Flavor.uat:

        return 'https://uat-cms.myairline.my/';
      default:
        return 'https://cms.myairline.my/';
    }
  }

  static String get baseUrlApi {
    switch (appFlavor) {
      case Flavor.staging:
        return 'http://uat-nav.api.myairline.my/api/mobile/';

        return 'https://mya-nav-api.alphareds.com/api/';
        return 'https://mya-api.alphareds.com/api/mobile/';
      case Flavor.uat:
        ///return 'http://uat-nav.api.myairline.my/api/mobile/';

        return 'https://uat-nav-api.myairline.my/api/mobile/';
      default:
        return 'https://api.myairline.my/api/mobile/';
    }
  }

  static String get minimumVersion {
    switch (appFlavor) {
      case Flavor.staging:
        return 'minimumVersionUat';
      case Flavor.uat:
        return 'minimumVersionUat';
      default:
        return 'minimumVersion';
    }
  }

  static String get recommendedVersion {
    switch (appFlavor) {
      case Flavor.staging:
        return 'recommendedVersionUat';
      case Flavor.uat:
        return 'recommendedVersionUat';
      default:
        return 'recommendedVersion';
    }
  }

  static String get insiderPartnerName {
    switch (appFlavor) {
      case Flavor.staging:
        return 'myairlineuat';
      case Flavor.uat:
        return 'myairlineuat';
      default:
        return 'myairline';
    }
  }

  static String get insiderAppGroup {
    final isAndroid = Platform.isAndroid;
    switch (appFlavor) {
      case Flavor.staging:
        return isAndroid ? '' : 'group.com.myairline.mobileapp.uat';
      case Flavor.uat:
        return isAndroid ? '' : 'group.com.myairline.mobileapp.uat';
      default:
        return isAndroid ? '' : 'group.com.myairline.mobileapp';
    }
  }
}




/*
class AppFlavor {
  static Flavor appFlavor = Flavor.staging;

  static String get title {
    switch (appFlavor) {
      case Flavor.staging:
        return 'MYAirline - PrePod';
      case Flavor.uat:
        return 'MYAirline - PrePod';
      default:
        return 'MYAirline';
    }
  }

  static FirebaseOptions get firebaseOptions {
    switch (appFlavor) {
      case Flavor.staging:
        return staging.DefaultFirebaseOptions.currentPlatform;
      case Flavor.uat:
        return uat.DefaultFirebaseOptions.currentPlatform;
      default:
        return production.DefaultFirebaseOptions.currentPlatform;
    }
  }

  static String get paymentRedirectUrl {
    switch (appFlavor) {
      case Flavor.staging:




        return 'http://preprd.myairline.my/booked';
    //return 'https://mya-nav-web.alphareds.com/booked';

      case Flavor.uat:

        return 'http://preprd.myairline.my/booked';

        return 'https://uat-nav-booking.myairline.my/booked';
      default:
        return 'https://booking.myairline.my/booked';
    }
  }

  static String get websiteUrl {
    switch (appFlavor) {
      case Flavor.staging:

      //https://preprd-api.myairline.my/

        return 'https://preprd.myairline.my/';
      case Flavor.uat:
      // return 'http://uat-nav.api.myairline.my/';
        return 'https://preprd.myairline.my/';
        return 'https://uat-nav.myairline.my';
      default:
        return 'https://www.myairline.my';
    }
  }

  static String get thirdPartyUrl {
    switch (appFlavor) {
      case Flavor.staging:
        return 'http://uat-nav.api.myairline.my/';
        return 'https://mya-nav-booking.alphareds.com';
        //https://mya-nav-booking.alphareds.com
        return 'https://myairline-gcp-cert-ezycommerce.ezyflight.se';
      case Flavor.uat:
        return 'https://myairline-gcp-cert-ezycommerce.ezyflight.se';
      default:
        return 'https://mybooking.myairline.my';
    }
  }

  static String get baseUrlCMS {
    switch (appFlavor) {
      case Flavor.staging:
        return 'https://uat-cms.myairline.my/';
      case Flavor.uat:
        return 'https://uat-cms.myairline.my/';
      default:
        return 'https://cms.myairline.my/';
    }
  }

  static String get baseUrlApi {
    switch (appFlavor) {
      case Flavor.staging:

        return  'https://preprd-api.myairline.my/';

        return 'https://mya-nav-api.alphareds.com/api/';
        return 'https://mya-api.alphareds.com/api/mobile/';
      case Flavor.uat:
      ///return 'http://uat-nav.api.myairline.my/api/mobile/';

        return 'https://preprd-api.myairline.my/api/';
        //  return  'https://preprd-api.myairline.my/';
        return 'https://uat-nav-api.myairline.my/api/mobile/';
      default:
        return 'https://api.myairline.my/api/mobile/';
    }
  }

  static String get minimumVersion {
    switch (appFlavor) {
      case Flavor.staging:
        return 'minimumVersionUat';
      case Flavor.uat:
        return 'minimumVersionUat';
      default:
        return 'minimumVersion';
    }
  }

  static String get recommendedVersion {
    switch (appFlavor) {
      case Flavor.staging:
        return 'recommendedVersionUat';
      case Flavor.uat:
        return 'recommendedVersionUat';
      default:
        return 'recommendedVersion';
    }
  }

  static String get insiderPartnerName {
    switch (appFlavor) {
      case Flavor.staging:
        return 'myairlineuat';
      case Flavor.uat:
        return 'myairlineuat';
      default:
        return 'myairline';
    }
  }

  static String get insiderAppGroup {
    final isAndroid = Platform.isAndroid;
    switch (appFlavor) {
      case Flavor.staging:
        return isAndroid ? '' : 'group.com.myairline.mobileapp.uat';
      case Flavor.uat:
        return isAndroid ? '' : 'group.com.myairline.mobileapp.uat';
      default:
        return isAndroid ? '' : 'group.com.myairline.mobileapp';
    }
  }
}
*/