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
    NavigationRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const NavigationPage(),
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
    BundleRoute.name: (routeData) {
      final args = routeData.argsAs<BundleRouteArgs>(
          orElse: () => const BundleRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: BundlePage(
          key: args.key,
          isDeparture: args.isDeparture,
        ),
      );
    },
    SeatsRoute.name: (routeData) {
      final args = routeData.argsAs<SeatsRouteArgs>(
          orElse: () => const SeatsRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SeatsPage(
          key: args.key,
          isDeparture: args.isDeparture,
        ),
      );
    },
    MealsRoute.name: (routeData) {
      final args = routeData.argsAs<MealsRouteArgs>(
          orElse: () => const MealsRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: MealsPage(
          key: args.key,
          isDeparture: args.isDeparture,
        ),
      );
    },
    BaggageRoute.name: (routeData) {
      final args = routeData.argsAs<BaggageRouteArgs>(
          orElse: () => const BaggageRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: BaggagePage(
          key: args.key,
          isDeparture: args.isDeparture,
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
    PaymentRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const PaymentPage(),
      );
    },
    BookingListRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BookingListPage(),
      );
    },
    CompleteSignupRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteSignupRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CompleteSignupPage(
          key: args.key,
          signupRequest: args.signupRequest,
        ),
      );
    },
    BookingConfirmationRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<BookingConfirmationRouteArgs>(
          orElse: () => BookingConfirmationRouteArgs(
              bookingId: pathParams.getString('id')));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: BookingConfirmationPage(
          key: args.key,
          bookingId: args.bookingId,
        ),
      );
    },
    SignupWrapperRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SignupWrapperPage(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const EditProfilePage(),
      );
    },
    PersonalInfoRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const PersonalInfoPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    DealsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DealsPage(),
      );
    },
    BookingsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const BookingsPage(),
      );
    },
    CheckInRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CheckInPage(),
      );
    },
    AuthRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    SignupAccountRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SignupAccountPage(),
      );
    },
    SignupAddressRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SignupAddressPage(),
      );
    },
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/navigation',
          fullMatch: true,
        ),
        RouteConfig(
          NavigationRoute.name,
          path: '/navigation',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: NavigationRoute.name,
              redirectTo: 'home',
              fullMatch: true,
            ),
            RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: NavigationRoute.name,
            ),
            RouteConfig(
              DealsRoute.name,
              path: 'deals',
              parent: NavigationRoute.name,
            ),
            RouteConfig(
              BookingsRoute.name,
              path: 'bookings',
              parent: NavigationRoute.name,
            ),
            RouteConfig(
              CheckInRoute.name,
              path: 'check-in',
              parent: NavigationRoute.name,
            ),
            RouteConfig(
              AuthRoute.name,
              path: 'auth',
              parent: NavigationRoute.name,
            ),
          ],
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
          BundleRoute.name,
          path: '/flight/addon/new-bundle',
        ),
        RouteConfig(
          SeatsRoute.name,
          path: '/flight/addon/new-seats',
        ),
        RouteConfig(
          MealsRoute.name,
          path: '/flight/addon/new-meals',
        ),
        RouteConfig(
          BaggageRoute.name,
          path: '/flight/addon/new-baggage',
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
          PaymentRoute.name,
          path: '/payment',
        ),
        RouteConfig(
          BookingListRoute.name,
          path: '/booking-list',
        ),
        RouteConfig(
          CompleteSignupRoute.name,
          path: '/complete-signup',
        ),
        RouteConfig(
          BookingConfirmationRoute.name,
          path: '/booking-confirmation/:id',
        ),
        RouteConfig(
          SignupWrapperRoute.name,
          path: 'signup',
          children: [
            RouteConfig(
              '#redirect',
              path: '',
              parent: SignupWrapperRoute.name,
              redirectTo: '1',
              fullMatch: true,
            ),
            RouteConfig(
              SignupAccountRoute.name,
              path: '1',
              parent: SignupWrapperRoute.name,
            ),
            RouteConfig(
              SignupAddressRoute.name,
              path: '2',
              parent: SignupWrapperRoute.name,
            ),
          ],
        ),
        RouteConfig(
          EditProfileRoute.name,
          path: '/edit-profile',
        ),
        RouteConfig(
          PersonalInfoRoute.name,
          path: '/personal-info',
        ),
      ];
}

/// generated route for
/// [NavigationPage]
class NavigationRoute extends PageRouteInfo<void> {
  const NavigationRoute({List<PageRouteInfo>? children})
      : super(
          NavigationRoute.name,
          path: '/navigation',
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';
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
/// [BundlePage]
class BundleRoute extends PageRouteInfo<BundleRouteArgs> {
  BundleRoute({
    Key? key,
    bool isDeparture = true,
  }) : super(
          BundleRoute.name,
          path: '/flight/addon/new-bundle',
          args: BundleRouteArgs(
            key: key,
            isDeparture: isDeparture,
          ),
        );

  static const String name = 'BundleRoute';
}

class BundleRouteArgs {
  const BundleRouteArgs({
    this.key,
    this.isDeparture = true,
  });

  final Key? key;

  final bool isDeparture;

  @override
  String toString() {
    return 'BundleRouteArgs{key: $key, isDeparture: $isDeparture}';
  }
}

/// generated route for
/// [SeatsPage]
class SeatsRoute extends PageRouteInfo<SeatsRouteArgs> {
  SeatsRoute({
    Key? key,
    bool isDeparture = true,
  }) : super(
          SeatsRoute.name,
          path: '/flight/addon/new-seats',
          args: SeatsRouteArgs(
            key: key,
            isDeparture: isDeparture,
          ),
        );

  static const String name = 'SeatsRoute';
}

class SeatsRouteArgs {
  const SeatsRouteArgs({
    this.key,
    this.isDeparture = true,
  });

  final Key? key;

  final bool isDeparture;

  @override
  String toString() {
    return 'SeatsRouteArgs{key: $key, isDeparture: $isDeparture}';
  }
}

/// generated route for
/// [MealsPage]
class MealsRoute extends PageRouteInfo<MealsRouteArgs> {
  MealsRoute({
    Key? key,
    bool isDeparture = true,
  }) : super(
          MealsRoute.name,
          path: '/flight/addon/new-meals',
          args: MealsRouteArgs(
            key: key,
            isDeparture: isDeparture,
          ),
        );

  static const String name = 'MealsRoute';
}

class MealsRouteArgs {
  const MealsRouteArgs({
    this.key,
    this.isDeparture = true,
  });

  final Key? key;

  final bool isDeparture;

  @override
  String toString() {
    return 'MealsRouteArgs{key: $key, isDeparture: $isDeparture}';
  }
}

/// generated route for
/// [BaggagePage]
class BaggageRoute extends PageRouteInfo<BaggageRouteArgs> {
  BaggageRoute({
    Key? key,
    bool isDeparture = true,
  }) : super(
          BaggageRoute.name,
          path: '/flight/addon/new-baggage',
          args: BaggageRouteArgs(
            key: key,
            isDeparture: isDeparture,
          ),
        );

  static const String name = 'BaggageRoute';
}

class BaggageRouteArgs {
  const BaggageRouteArgs({
    this.key,
    this.isDeparture = true,
  });

  final Key? key;

  final bool isDeparture;

  @override
  String toString() {
    return 'BaggageRouteArgs{key: $key, isDeparture: $isDeparture}';
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
/// [PaymentPage]
class PaymentRoute extends PageRouteInfo<void> {
  const PaymentRoute()
      : super(
          PaymentRoute.name,
          path: '/payment',
        );

  static const String name = 'PaymentRoute';
}

/// generated route for
/// [BookingListPage]
class BookingListRoute extends PageRouteInfo<void> {
  const BookingListRoute()
      : super(
          BookingListRoute.name,
          path: '/booking-list',
        );

  static const String name = 'BookingListRoute';
}

/// generated route for
/// [CompleteSignupPage]
class CompleteSignupRoute extends PageRouteInfo<CompleteSignupRouteArgs> {
  CompleteSignupRoute({
    Key? key,
    required SignupRequest signupRequest,
  }) : super(
          CompleteSignupRoute.name,
          path: '/complete-signup',
          args: CompleteSignupRouteArgs(
            key: key,
            signupRequest: signupRequest,
          ),
        );

  static const String name = 'CompleteSignupRoute';
}

class CompleteSignupRouteArgs {
  const CompleteSignupRouteArgs({
    this.key,
    required this.signupRequest,
  });

  final Key? key;

  final SignupRequest signupRequest;

  @override
  String toString() {
    return 'CompleteSignupRouteArgs{key: $key, signupRequest: $signupRequest}';
  }
}

/// generated route for
/// [BookingConfirmationPage]
class BookingConfirmationRoute
    extends PageRouteInfo<BookingConfirmationRouteArgs> {
  BookingConfirmationRoute({
    Key? key,
    required String bookingId,
  }) : super(
          BookingConfirmationRoute.name,
          path: '/booking-confirmation/:id',
          args: BookingConfirmationRouteArgs(
            key: key,
            bookingId: bookingId,
          ),
          rawPathParams: {'id': bookingId},
        );

  static const String name = 'BookingConfirmationRoute';
}

class BookingConfirmationRouteArgs {
  const BookingConfirmationRouteArgs({
    this.key,
    required this.bookingId,
  });

  final Key? key;

  final String bookingId;

  @override
  String toString() {
    return 'BookingConfirmationRouteArgs{key: $key, bookingId: $bookingId}';
  }
}

/// generated route for
/// [SignupWrapperPage]
class SignupWrapperRoute extends PageRouteInfo<void> {
  const SignupWrapperRoute({List<PageRouteInfo>? children})
      : super(
          SignupWrapperRoute.name,
          path: 'signup',
          initialChildren: children,
        );

  static const String name = 'SignupWrapperRoute';
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute()
      : super(
          EditProfileRoute.name,
          path: '/edit-profile',
        );

  static const String name = 'EditProfileRoute';
}

/// generated route for
/// [PersonalInfoPage]
class PersonalInfoRoute extends PageRouteInfo<void> {
  const PersonalInfoRoute()
      : super(
          PersonalInfoRoute.name,
          path: '/personal-info',
        );

  static const String name = 'PersonalInfoRoute';
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [DealsPage]
class DealsRoute extends PageRouteInfo<void> {
  const DealsRoute()
      : super(
          DealsRoute.name,
          path: 'deals',
        );

  static const String name = 'DealsRoute';
}

/// generated route for
/// [BookingsPage]
class BookingsRoute extends PageRouteInfo<void> {
  const BookingsRoute()
      : super(
          BookingsRoute.name,
          path: 'bookings',
        );

  static const String name = 'BookingsRoute';
}

/// generated route for
/// [CheckInPage]
class CheckInRoute extends PageRouteInfo<void> {
  const CheckInRoute()
      : super(
          CheckInRoute.name,
          path: 'check-in',
        );

  static const String name = 'CheckInRoute';
}

/// generated route for
/// [AuthPage]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: 'auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [SignupAccountPage]
class SignupAccountRoute extends PageRouteInfo<void> {
  const SignupAccountRoute()
      : super(
          SignupAccountRoute.name,
          path: '1',
        );

  static const String name = 'SignupAccountRoute';
}

/// generated route for
/// [SignupAddressPage]
class SignupAddressRoute extends PageRouteInfo<void> {
  const SignupAddressRoute()
      : super(
          SignupAddressRoute.name,
          path: '2',
        );

  static const String name = 'SignupAddressRoute';
}
