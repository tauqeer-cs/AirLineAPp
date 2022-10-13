// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    SearchResultRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SearchResultPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
    WebViewRoute.name: (routeData) {
      final args = routeData.argsAs<WebViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WebViewPage(
          key: args.key,
          url: args.url,
          title: args.title,
          htmlContent: args.htmlContent,
        ),
      );
    },
    InAppWebViewRoute.name: (routeData) {
      final args = routeData.argsAs<InAppWebViewRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: InAppWebViewPage(
          key: args.key,
          url: args.url,
        ),
      );
    },
    SelectBundleRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SelectBundlePage(),
      );
    },
    SelectSeatsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SelectSeatsPage(),
      );
    },
    SelectMealsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SelectMealsPage(),
      );
    },
    SelectBaggageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SelectBaggagePage(),
      );
    },
    BookingDetailsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BookingDetailsPage(),
      );
    },
    CheckoutRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CheckoutPage(),
      );
    },
    BookingConfirmationRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BookingConfirmationPage(),
      );
    },
    PaymentRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const PaymentPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/home',
          fullMatch: true,
        ),
        RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        RouteConfig(
          SearchResultRoute.name,
          path: '/flight',
        ),
        RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        RouteConfig(
          WebViewRoute.name,
          path: '/webview',
        ),
        RouteConfig(
          InAppWebViewRoute.name,
          path: '/in-app-webview',
        ),
        RouteConfig(
          SelectBundleRoute.name,
          path: '/flight/addon/bundle',
        ),
        RouteConfig(
          SelectSeatsRoute.name,
          path: '/flight/addon/seat',
        ),
        RouteConfig(
          SelectMealsRoute.name,
          path: '/flight/addon/meal',
        ),
        RouteConfig(
          SelectBaggageRoute.name,
          path: '/flight/addon/baggage',
        ),
        RouteConfig(
          BookingDetailsRoute.name,
          path: '/booking-details',
        ),
        RouteConfig(
          CheckoutRoute.name,
          path: '/checkout',
        ),
        RouteConfig(
          BookingConfirmationRoute.name,
          path: '/booking-confirmation',
        ),
        RouteConfig(
          PaymentRoute.name,
          path: '/payment',
        ),
      ];
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [SearchResultPage]
class SearchResultRoute extends PageRouteInfo<void> {
  const SearchResultRoute()
      : super(
          SearchResultRoute.name,
          path: '/flight',
        );

  static const String name = 'SearchResultRoute';
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [WebViewPage]
class WebViewRoute extends PageRouteInfo<WebViewRouteArgs> {
  WebViewRoute({
    Key? key,
    required String url,
    String? title,
    String? htmlContent,
  }) : super(
          WebViewRoute.name,
          path: '/webview',
          args: WebViewRouteArgs(
            key: key,
            url: url,
            title: title,
            htmlContent: htmlContent,
          ),
        );

  static const String name = 'WebViewRoute';
}

class WebViewRouteArgs {
  const WebViewRouteArgs({
    this.key,
    required this.url,
    this.title,
    this.htmlContent,
  });

  final Key? key;

  final String url;

  final String? title;

  final String? htmlContent;

  @override
  String toString() {
    return 'WebViewRouteArgs{key: $key, url: $url, title: $title, htmlContent: $htmlContent}';
  }
}

/// generated route for
/// [InAppWebViewPage]
class InAppWebViewRoute extends PageRouteInfo<InAppWebViewRouteArgs> {
  InAppWebViewRoute({
    Key? key,
    required String url,
  }) : super(
          InAppWebViewRoute.name,
          path: '/in-app-webview',
          args: InAppWebViewRouteArgs(
            key: key,
            url: url,
          ),
        );

  static const String name = 'InAppWebViewRoute';
}

class InAppWebViewRouteArgs {
  const InAppWebViewRouteArgs({
    this.key,
    required this.url,
  });

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'InAppWebViewRouteArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [SelectBundlePage]
class SelectBundleRoute extends PageRouteInfo<void> {
  const SelectBundleRoute()
      : super(
          SelectBundleRoute.name,
          path: '/flight/addon/bundle',
        );

  static const String name = 'SelectBundleRoute';
}

/// generated route for
/// [SelectSeatsPage]
class SelectSeatsRoute extends PageRouteInfo<void> {
  const SelectSeatsRoute()
      : super(
          SelectSeatsRoute.name,
          path: '/flight/addon/seat',
        );

  static const String name = 'SelectSeatsRoute';
}

/// generated route for
/// [SelectMealsPage]
class SelectMealsRoute extends PageRouteInfo<void> {
  const SelectMealsRoute()
      : super(
          SelectMealsRoute.name,
          path: '/flight/addon/meal',
        );

  static const String name = 'SelectMealsRoute';
}

/// generated route for
/// [SelectBaggagePage]
class SelectBaggageRoute extends PageRouteInfo<void> {
  const SelectBaggageRoute()
      : super(
          SelectBaggageRoute.name,
          path: '/flight/addon/baggage',
        );

  static const String name = 'SelectBaggageRoute';
}

/// generated route for
/// [BookingDetailsPage]
class BookingDetailsRoute extends PageRouteInfo<void> {
  const BookingDetailsRoute()
      : super(
          BookingDetailsRoute.name,
          path: '/booking-details',
        );

  static const String name = 'BookingDetailsRoute';
}

/// generated route for
/// [CheckoutPage]
class CheckoutRoute extends PageRouteInfo<void> {
  const CheckoutRoute()
      : super(
          CheckoutRoute.name,
          path: '/checkout',
        );

  static const String name = 'CheckoutRoute';
}

/// generated route for
/// [BookingConfirmationPage]
class BookingConfirmationRoute extends PageRouteInfo<void> {
  const BookingConfirmationRoute()
      : super(
          BookingConfirmationRoute.name,
          path: '/booking-confirmation',
        );

  static const String name = 'BookingConfirmationRoute';
}

/// generated route for
/// [PaymentPage]
class PaymentRoute extends PageRouteInfo<void> {
  const PaymentRoute()
      : super(
          PaymentRoute.name,
          path: '/payment',
        );

  static const String name = 'PaymentRoute';
}
