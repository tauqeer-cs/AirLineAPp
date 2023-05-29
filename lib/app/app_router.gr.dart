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
      final args = routeData.argsAs<SearchResultRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SearchResultPage(
          key: args.key,
          showLoginDialog: args.showLoginDialog,
        ),
      );
    },
    ChangeSearchRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ChangeSearchPage(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
    HomeDetailRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeDetailRouteArgs>(
          orElse: () => HomeDetailRouteArgs(url: pathParams.getString('url')));
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: HomeDetailPage(
          key: args.key,
          url: args.url,
        ),
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
    WebViewSimpleRoute.name: (routeData) {
      final args = routeData.argsAs<WebViewSimpleRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: WebViewSimplePage(
          key: args.key,
          url: args.url,
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
          title: args.title,
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
    SpecialRoute.name: (routeData) {
      final args = routeData.argsAs<SpecialRouteArgs>(
          orElse: () => const SpecialRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: SpecialPage(
          key: args.key,
          isDeparture: args.isDeparture,
        ),
      );
    },
    SummaryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SummaryPage(),
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
    InsuranceRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const InsurancePage(),
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
      final args = routeData.argsAs<BookingConfirmationRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: BookingConfirmationPage(
          key: args.key,
          bookingId: args.bookingId,
          status: args.status,
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
    AccountSettingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const AccountSettingPage(),
      );
    },
    CommunicationSettingRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CommunicationSettingPage(),
      );
    },
    ForgetPasswordRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ForgetPasswordPage(),
      );
    },
    DeleteAccountRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const DeleteAccountPage(),
      );
    },
    FriendsFamilyRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const FriendsFamilyPage(),
      );
    },
    MemberCardsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MemberCardsPage(),
      );
    },
    MoreOptionsRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const MoreOptionsPage(),
      );
    },
    ManageBookingDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<ManageBookingDetailsRouteArgs>(
          orElse: () => const ManageBookingDetailsRouteArgs());
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ManageBookingDetailsPage(key: args.key),
      );
    },
    NewTravelDatesRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const NewTravelDatesPage(),
      );
    },
    SelectChangeFlightRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const SelectChangeFlightPage(),
      );
    },
    ChangeFlightSummaryRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const ChangeFlightSummaryPage(),
      );
    },
    ChangeFlightConfirmationRoute.name: (routeData) {
      final args = routeData.argsAs<ChangeFlightConfirmationRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: ChangeFlightConfirmationPage(
          key: args.key,
          bookingId: args.bookingId,
        ),
      );
    },
    CheckInDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<CheckInDetailsRouteArgs>();
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: CheckInDetailsPage(
          key: args.key,
          isPast: args.isPast,
        ),
      );
    },
    CheckInBoardingPassRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CheckInBoardingPassPage(),
      );
    },
    CheckInErrorRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const CheckInErrorPage(),
      );
    },
    LanguageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
        routeData: routeData,
        child: const LanguagePage(),
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
          ChangeSearchRoute.name,
          path: '/change-search',
        ),
        RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        RouteConfig(
          HomeDetailRoute.name,
          path: '/:url',
        ),
        RouteConfig(
          WebViewRoute.name,
          path: '/webview',
        ),
        RouteConfig(
          WebViewSimpleRoute.name,
          path: '/webview-simple',
        ),
        RouteConfig(
          InAppWebViewRoute.name,
          path: '/in-app-webview',
        ),
        RouteConfig(
          BundleRoute.name,
          path: '/flight/addon/selection-bundle',
        ),
        RouteConfig(
          SeatsRoute.name,
          path: '/flight/addon/selection-seats',
        ),
        RouteConfig(
          MealsRoute.name,
          path: '/flight/addon/selection-meals',
        ),
        RouteConfig(
          BaggageRoute.name,
          path: '/flight/addon/selection-baggage',
        ),
        RouteConfig(
          SpecialRoute.name,
          path: '/flight/addon/selection-special',
        ),
        RouteConfig(
          SummaryRoute.name,
          path: '/flight/addon/summary',
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
          InsuranceRoute.name,
          path: '/insurance_page',
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
              redirectTo: 'signup/account',
              fullMatch: true,
            ),
            RouteConfig(
              SignupAccountRoute.name,
              path: 'signup/account',
              parent: SignupWrapperRoute.name,
            ),
            RouteConfig(
              SignupAddressRoute.name,
              path: 'signup/detail',
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
        RouteConfig(
          AccountSettingRoute.name,
          path: '/account-settings',
        ),
        RouteConfig(
          CommunicationSettingRoute.name,
          path: '/communication-settings',
        ),
        RouteConfig(
          ForgetPasswordRoute.name,
          path: '/forget-password',
        ),
        RouteConfig(
          DeleteAccountRoute.name,
          path: '/delete-account',
        ),
        RouteConfig(
          FriendsFamilyRoute.name,
          path: '/friends-family',
        ),
        RouteConfig(
          MemberCardsRoute.name,
          path: '/member-cards',
        ),
        RouteConfig(
          MoreOptionsRoute.name,
          path: '/more-options',
        ),
        RouteConfig(
          ManageBookingDetailsRoute.name,
          path: '/manage-booking-details',
        ),
        RouteConfig(
          NewTravelDatesRoute.name,
          path: '/new-travel-dates',
        ),
        RouteConfig(
          SelectChangeFlightRoute.name,
          path: '/select-change-flight',
        ),
        RouteConfig(
          ChangeFlightSummaryRoute.name,
          path: '/change-flight-summary',
        ),
        RouteConfig(
          ChangeFlightConfirmationRoute.name,
          path: '/change-flight-confirmation',
        ),
        RouteConfig(
          CheckInDetailsRoute.name,
          path: '/check_in_details',
        ),
        RouteConfig(
          CheckInBoardingPassRoute.name,
          path: '/check_in_boarding_pass',
        ),
        RouteConfig(
          CheckInErrorRoute.name,
          path: '/check_in_error',
        ),
        RouteConfig(
          LanguageRoute.name,
          path: '/language',
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
class SearchResultRoute extends PageRouteInfo<SearchResultRouteArgs> {
  SearchResultRoute({
    Key? key,
    required bool showLoginDialog,
  }) : super(
          SearchResultRoute.name,
          path: '/flight',
          args: SearchResultRouteArgs(
            key: key,
            showLoginDialog: showLoginDialog,
          ),
        );

  static const String name = 'SearchResultRoute';
}

class SearchResultRouteArgs {
  const SearchResultRouteArgs({
    this.key,
    required this.showLoginDialog,
  });

  final Key? key;

  final bool showLoginDialog;

  @override
  String toString() {
    return 'SearchResultRouteArgs{key: $key, showLoginDialog: $showLoginDialog}';
  }
}

/// generated route for
/// [ChangeSearchPage]
class ChangeSearchRoute extends PageRouteInfo<void> {
  const ChangeSearchRoute()
      : super(
          ChangeSearchRoute.name,
          path: '/change-search',
        );

  static const String name = 'ChangeSearchRoute';
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
/// [HomeDetailPage]
class HomeDetailRoute extends PageRouteInfo<HomeDetailRouteArgs> {
  HomeDetailRoute({
    Key? key,
    required String url,
  }) : super(
          HomeDetailRoute.name,
          path: '/:url',
          args: HomeDetailRouteArgs(
            key: key,
            url: url,
          ),
          rawPathParams: {'url': url},
        );

  static const String name = 'HomeDetailRoute';
}

class HomeDetailRouteArgs {
  const HomeDetailRouteArgs({
    this.key,
    required this.url,
  });

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'HomeDetailRouteArgs{key: $key, url: $url}';
  }
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
/// [WebViewSimplePage]
class WebViewSimpleRoute extends PageRouteInfo<WebViewSimpleRouteArgs> {
  WebViewSimpleRoute({
    Key? key,
    required String url,
  }) : super(
          WebViewSimpleRoute.name,
          path: '/webview-simple',
          args: WebViewSimpleRouteArgs(
            key: key,
            url: url,
          ),
        );

  static const String name = 'WebViewSimpleRoute';
}

class WebViewSimpleRouteArgs {
  const WebViewSimpleRouteArgs({
    this.key,
    required this.url,
  });

  final Key? key;

  final String url;

  @override
  String toString() {
    return 'WebViewSimpleRouteArgs{key: $key, url: $url}';
  }
}

/// generated route for
/// [InAppWebViewPage]
class InAppWebViewRoute extends PageRouteInfo<InAppWebViewRouteArgs> {
  InAppWebViewRoute({
    Key? key,
    required String url,
    String? title,
  }) : super(
          InAppWebViewRoute.name,
          path: '/in-app-webview',
          args: InAppWebViewRouteArgs(
            key: key,
            url: url,
            title: title,
          ),
        );

  static const String name = 'InAppWebViewRoute';
}

class InAppWebViewRouteArgs {
  const InAppWebViewRouteArgs({
    this.key,
    required this.url,
    this.title,
  });

  final Key? key;

  final String url;

  final String? title;

  @override
  String toString() {
    return 'InAppWebViewRouteArgs{key: $key, url: $url, title: $title}';
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
          path: '/flight/addon/selection-bundle',
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
          path: '/flight/addon/selection-seats',
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
          path: '/flight/addon/selection-meals',
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
          path: '/flight/addon/selection-baggage',
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
/// [SpecialPage]
class SpecialRoute extends PageRouteInfo<SpecialRouteArgs> {
  SpecialRoute({
    Key? key,
    bool isDeparture = true,
  }) : super(
          SpecialRoute.name,
          path: '/flight/addon/selection-special',
          args: SpecialRouteArgs(
            key: key,
            isDeparture: isDeparture,
          ),
        );

  static const String name = 'SpecialRoute';
}

class SpecialRouteArgs {
  const SpecialRouteArgs({
    this.key,
    this.isDeparture = true,
  });

  final Key? key;

  final bool isDeparture;

  @override
  String toString() {
    return 'SpecialRouteArgs{key: $key, isDeparture: $isDeparture}';
  }
}

/// generated route for
/// [SummaryPage]
class SummaryRoute extends PageRouteInfo<void> {
  const SummaryRoute()
      : super(
          SummaryRoute.name,
          path: '/flight/addon/summary',
        );

  static const String name = 'SummaryRoute';
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
/// [InsurancePage]
class InsuranceRoute extends PageRouteInfo<void> {
  const InsuranceRoute()
      : super(
          InsuranceRoute.name,
          path: '/insurance_page',
        );

  static const String name = 'InsuranceRoute';
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
    required String status,
  }) : super(
          BookingConfirmationRoute.name,
          path: '/booking-confirmation/:id',
          args: BookingConfirmationRouteArgs(
            key: key,
            bookingId: bookingId,
            status: status,
          ),
          rawPathParams: {'id': bookingId},
        );

  static const String name = 'BookingConfirmationRoute';
}

class BookingConfirmationRouteArgs {
  const BookingConfirmationRouteArgs({
    this.key,
    required this.bookingId,
    required this.status,
  });

  final Key? key;

  final String bookingId;

  final String status;

  @override
  String toString() {
    return 'BookingConfirmationRouteArgs{key: $key, bookingId: $bookingId, status: $status}';
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
/// [AccountSettingPage]
class AccountSettingRoute extends PageRouteInfo<void> {
  const AccountSettingRoute()
      : super(
          AccountSettingRoute.name,
          path: '/account-settings',
        );

  static const String name = 'AccountSettingRoute';
}

/// generated route for
/// [CommunicationSettingPage]
class CommunicationSettingRoute extends PageRouteInfo<void> {
  const CommunicationSettingRoute()
      : super(
          CommunicationSettingRoute.name,
          path: '/communication-settings',
        );

  static const String name = 'CommunicationSettingRoute';
}

/// generated route for
/// [ForgetPasswordPage]
class ForgetPasswordRoute extends PageRouteInfo<void> {
  const ForgetPasswordRoute()
      : super(
          ForgetPasswordRoute.name,
          path: '/forget-password',
        );

  static const String name = 'ForgetPasswordRoute';
}

/// generated route for
/// [DeleteAccountPage]
class DeleteAccountRoute extends PageRouteInfo<void> {
  const DeleteAccountRoute()
      : super(
          DeleteAccountRoute.name,
          path: '/delete-account',
        );

  static const String name = 'DeleteAccountRoute';
}

/// generated route for
/// [FriendsFamilyPage]
class FriendsFamilyRoute extends PageRouteInfo<void> {
  const FriendsFamilyRoute()
      : super(
          FriendsFamilyRoute.name,
          path: '/friends-family',
        );

  static const String name = 'FriendsFamilyRoute';
}

/// generated route for
/// [MemberCardsPage]
class MemberCardsRoute extends PageRouteInfo<void> {
  const MemberCardsRoute()
      : super(
          MemberCardsRoute.name,
          path: '/member-cards',
        );

  static const String name = 'MemberCardsRoute';
}

/// generated route for
/// [MoreOptionsPage]
class MoreOptionsRoute extends PageRouteInfo<void> {
  const MoreOptionsRoute()
      : super(
          MoreOptionsRoute.name,
          path: '/more-options',
        );

  static const String name = 'MoreOptionsRoute';
}

/// generated route for
/// [ManageBookingDetailsPage]
class ManageBookingDetailsRoute
    extends PageRouteInfo<ManageBookingDetailsRouteArgs> {
  ManageBookingDetailsRoute({Key? key})
      : super(
          ManageBookingDetailsRoute.name,
          path: '/manage-booking-details',
          args: ManageBookingDetailsRouteArgs(key: key),
        );

  static const String name = 'ManageBookingDetailsRoute';
}

class ManageBookingDetailsRouteArgs {
  const ManageBookingDetailsRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ManageBookingDetailsRouteArgs{key: $key}';
  }
}

/// generated route for
/// [NewTravelDatesPage]
class NewTravelDatesRoute extends PageRouteInfo<void> {
  const NewTravelDatesRoute()
      : super(
          NewTravelDatesRoute.name,
          path: '/new-travel-dates',
        );

  static const String name = 'NewTravelDatesRoute';
}

/// generated route for
/// [SelectChangeFlightPage]
class SelectChangeFlightRoute extends PageRouteInfo<void> {
  const SelectChangeFlightRoute()
      : super(
          SelectChangeFlightRoute.name,
          path: '/select-change-flight',
        );

  static const String name = 'SelectChangeFlightRoute';
}

/// generated route for
/// [ChangeFlightSummaryPage]
class ChangeFlightSummaryRoute extends PageRouteInfo<void> {
  const ChangeFlightSummaryRoute()
      : super(
          ChangeFlightSummaryRoute.name,
          path: '/change-flight-summary',
        );

  static const String name = 'ChangeFlightSummaryRoute';
}

/// generated route for
/// [ChangeFlightConfirmationPage]
class ChangeFlightConfirmationRoute
    extends PageRouteInfo<ChangeFlightConfirmationRouteArgs> {
  ChangeFlightConfirmationRoute({
    Key? key,
    required String bookingId,
  }) : super(
          ChangeFlightConfirmationRoute.name,
          path: '/change-flight-confirmation',
          args: ChangeFlightConfirmationRouteArgs(
            key: key,
            bookingId: bookingId,
          ),
        );

  static const String name = 'ChangeFlightConfirmationRoute';
}

class ChangeFlightConfirmationRouteArgs {
  const ChangeFlightConfirmationRouteArgs({
    this.key,
    required this.bookingId,
  });

  final Key? key;

  final String bookingId;

  @override
  String toString() {
    return 'ChangeFlightConfirmationRouteArgs{key: $key, bookingId: $bookingId}';
  }
}

/// generated route for
/// [CheckInDetailsPage]
class CheckInDetailsRoute extends PageRouteInfo<CheckInDetailsRouteArgs> {
  CheckInDetailsRoute({
    Key? key,
    required bool isPast,
  }) : super(
          CheckInDetailsRoute.name,
          path: '/check_in_details',
          args: CheckInDetailsRouteArgs(
            key: key,
            isPast: isPast,
          ),
        );

  static const String name = 'CheckInDetailsRoute';
}

class CheckInDetailsRouteArgs {
  const CheckInDetailsRouteArgs({
    this.key,
    required this.isPast,
  });

  final Key? key;

  final bool isPast;

  @override
  String toString() {
    return 'CheckInDetailsRouteArgs{key: $key, isPast: $isPast}';
  }
}

/// generated route for
/// [CheckInBoardingPassPage]
class CheckInBoardingPassRoute extends PageRouteInfo<void> {
  const CheckInBoardingPassRoute()
      : super(
          CheckInBoardingPassRoute.name,
          path: '/check_in_boarding_pass',
        );

  static const String name = 'CheckInBoardingPassRoute';
}

/// generated route for
/// [CheckInErrorPage]
class CheckInErrorRoute extends PageRouteInfo<void> {
  const CheckInErrorRoute()
      : super(
          CheckInErrorRoute.name,
          path: '/check_in_error',
        );

  static const String name = 'CheckInErrorRoute';
}

/// generated route for
/// [LanguagePage]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute()
      : super(
          LanguageRoute.name,
          path: '/language',
        );

  static const String name = 'LanguageRoute';
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
          path: 'signup/account',
        );

  static const String name = 'SignupAccountRoute';
}

/// generated route for
/// [SignupAddressPage]
class SignupAddressRoute extends PageRouteInfo<void> {
  const SignupAddressRoute()
      : super(
          SignupAddressRoute.name,
          path: 'signup/detail',
        );

  static const String name = 'SignupAddressRoute';
}
