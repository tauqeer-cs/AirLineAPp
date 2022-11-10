import 'package:app/data/requests/signup_request.dart';
import 'package:app/pages/account_setting/account_setting_page.dart';
import 'package:app/pages/add_on/baggage/baggage_page.dart';
import 'package:app/pages/add_on/bundle/bundle_page.dart';
import 'package:app/pages/add_on/meals/meals_page.dart';
import 'package:app/pages/add_on/seats/seats_page.dart';
import 'package:app/pages/auth/auth_page.dart';
import 'package:app/pages/auth/pages/complete_signup/complete_signup_page.dart';
import 'package:app/pages/auth/pages/signup/signup_account.dart';
import 'package:app/pages/auth/pages/signup/signup_address.dart';
import 'package:app/pages/auth/pages/signup/signup_wrapper.dart';
import 'package:app/pages/bookings/bookings_page.dart';
import 'package:app/pages/change_search/change_search_page.dart';
import 'package:app/pages/check_in/check_in_page.dart';
import 'package:app/pages/checkout/pages/booking_confirmation/booking_confirmation_page.dart';
import 'package:app/pages/checkout/pages/booking_details/booking_details.dart';
import 'package:app/pages/checkout/pages/booking_list/booking_list_page.dart';
import 'package:app/pages/checkout/pages/checkout/checkout_page.dart';
import 'package:app/pages/checkout/pages/payment/payment_page.dart';
import 'package:app/pages/checkout/pages/select_baggage/select_baggage_page.dart';
import 'package:app/pages/checkout/pages/select_bundle/select_bundle_page.dart';
import 'package:app/pages/checkout/pages/select_meals/select_meals_page.dart';
import 'package:app/pages/checkout/pages/select_seats/select_seats_page.dart';
import 'package:app/pages/communication_settings/communication_settings_page.dart';
import 'package:app/pages/deals/deals_page.dart';
import 'package:app/pages/edit_profile/edit_profile.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/inapp_webview/in_app_webview_page.dart';
import 'package:app/pages/navigation/navigation_page.dart';
import 'package:app/pages/search_result/search_result_page.dart';
import 'package:app/pages/webview/webview_page.dart';
import 'package:app/pages/welcome/welcome_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/personal_info/personal_info_page.dart';

part 'app_router.gr.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      page: NavigationPage,
      path: "/navigation",
      initial: true,
      children: [
        AutoRoute(page: HomePage, initial: true, path: "home"),
        AutoRoute(page: DealsPage, path: "deals"),
        AutoRoute(page: BookingsPage, path: "bookings"),
        AutoRoute(page: CheckInPage, path: "check-in"),
        AutoRoute(page: AuthPage, path: "auth"),
      ],
    ),
    AutoRoute(page: SearchResultPage, path: "/flight"),
    AutoRoute(page: ChangeSearchPage, path: "/change-search"),
    AutoRoute(page: WelcomePage, path: "/welcome"),
    AutoRoute(page: WebViewPage, path: "/webview"),
    AutoRoute(page: InAppWebViewPage, path: "/in-app-webview"),
    AutoRoute(page: BundlePage, path: "/flight/addon/new-bundle"),
    AutoRoute(page: SeatsPage, path: "/flight/addon/new-seats"),
    AutoRoute(page: MealsPage, path: "/flight/addon/new-meals"),
    AutoRoute(page: BaggagePage, path: "/flight/addon/new-baggage"),
    AutoRoute(page: SelectBundlePage, path: "/flight/addon/bundle"),
    AutoRoute(page: SelectSeatsPage, path: "/flight/addon/seat"),
    AutoRoute(page: SelectMealsPage, path: "/flight/addon/meal"),
    AutoRoute(page: SelectBaggagePage, path: "/flight/addon/baggage"),
    AutoRoute(page: BookingDetailsPage, path: "/booking-details"),
    AutoRoute(page: CheckoutPage, path: "/checkout"),
    AutoRoute(page: PaymentPage, path: "/payment"),
    AutoRoute(page: BookingListPage, path: "/booking-list"),
    AutoRoute(page: CompleteSignupPage, path: "/complete-signup"),
    AutoRoute(page: BookingConfirmationPage, path: "/booking-confirmation/:id"),
    AutoRoute(
      page: SignupWrapperPage,
      path: 'signup',
      children: [
        AutoRoute(page: SignupAccountPage, path: '1', initial: true),
        AutoRoute(page: SignupAddressPage, path: '2'),
      ],
    ),
    AutoRoute(page: EditProfilePage, path: "/edit-profile"),
    AutoRoute(page: PersonalInfoPage, path: "/personal-info"),
    AutoRoute(page: AccountSettingPage, path: "/account-settings"),
    AutoRoute(page: CommunicationSettingPage, path: "/communication-settings"),

  ],
)
class AppRouter extends _$AppRouter {}
