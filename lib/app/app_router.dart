import 'package:app/data/requests/signup_request.dart';
import 'package:app/pages/account_setting/account_setting_page.dart';
import 'package:app/pages/add_on/baggage/baggage_page.dart';
import 'package:app/pages/add_on/bundle/bundle_page.dart';
import 'package:app/pages/add_on/meals/meals_page.dart';
import 'package:app/pages/add_on/seats/seats_page.dart';
import 'package:app/pages/add_on/special/special_page.dart';
import 'package:app/pages/add_on/summary/summary_page.dart';
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
import 'package:app/pages/checkout/pages/insurance/insurance_page.dart';
import 'package:app/pages/checkout/pages/payment/payment_page.dart';
import 'package:app/pages/checkout/pages/select_baggage/select_baggage_page.dart';
import 'package:app/pages/checkout/pages/select_bundle/select_bundle_page.dart';
import 'package:app/pages/checkout/pages/select_meals/select_meals_page.dart';
import 'package:app/pages/checkout/pages/select_seats/select_seats_page.dart';
import 'package:app/pages/communication_settings/communication_settings_page.dart';
import 'package:app/pages/deals/deals_page.dart';
import 'package:app/pages/delete_account/delete_account_page.dart';
import 'package:app/pages/edit_profile/edit_profile.dart';
import 'package:app/pages/forget_password/forget_password_page.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/home_detail/home_detail_page.dart';
import 'package:app/pages/inapp_webview/in_app_webview_page.dart';
import 'package:app/pages/language/language_page.dart';
import 'package:app/pages/navigation/navigation_page.dart';
import 'package:app/pages/search_result/search_result_page.dart';
import 'package:app/pages/webview/webview_page.dart';
import 'package:app/pages/webview_simple/webview_page.dart';
import 'package:app/pages/welcome/welcome_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/personal_info/personal_info_page.dart';

import '../pages/booking_details/booking_details_page.dart';
import '../pages/change_flight_confirmation/change_flght_confirmation_page.dart';
import '../pages/change_flight_summary/change_flight_summary_page.dart';
import '../pages/friends_family/friend_family_page.dart';
import '../pages/member_cards/member_cards_page.dart';
import '../pages/more_info/more_info_page.dart';
import '../pages/new_travel_date/new_travel_date_page.dart';
import '../pages/select_change_flight/select_change_flight_page.dart';

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
    AutoRoute(page: HomeDetailPage, path: "/:url"),
    AutoRoute(page: WebViewPage, path: "/webview"),
    AutoRoute(page: WebViewSimplePage, path: "/webview-simple"),
    AutoRoute(page: InAppWebViewPage, path: "/in-app-webview"),
    AutoRoute(page: BundlePage, path: "/flight/addon/selection-bundle"),
    AutoRoute(page: SeatsPage, path: "/flight/addon/selection-seats"),
    AutoRoute(page: MealsPage, path: "/flight/addon/selection-meals"),
    AutoRoute(page: BaggagePage, path: "/flight/addon/selection-baggage"),
    AutoRoute(page: SpecialPage, path: "/flight/addon/selection-special"),
    AutoRoute(page: SummaryPage, path: "/flight/addon/summary"),
    AutoRoute(page: SelectBundlePage, path: "/flight/addon/bundle"),
    AutoRoute(page: SelectSeatsPage, path: "/flight/addon/seat"),
    AutoRoute(page: SelectMealsPage, path: "/flight/addon/meal"),
    AutoRoute(page: SelectBaggagePage, path: "/flight/addon/baggage"),
    AutoRoute(page: BookingDetailsPage, path: "/booking-details"),
    AutoRoute(page: InsurancePage, path: "/insurance_page"),
    AutoRoute(page: CheckoutPage, path: "/checkout"),
    AutoRoute(page: PaymentPage, path: "/payment"),
    AutoRoute(page: BookingListPage, path: "/booking-list"),
    AutoRoute(page: CompleteSignupPage, path: "/complete-signup"),
    AutoRoute(page: BookingConfirmationPage, path: "/booking-confirmation/:id"),
    AutoRoute(
      page: SignupWrapperPage,
      path: 'signup',
      children: [
        AutoRoute(
            page: SignupAccountPage, path: 'signup/account', initial: true),
        AutoRoute(page: SignupAddressPage, path: 'signup/detail'),
      ],
    ),
    AutoRoute(page: EditProfilePage, path: "/edit-profile"),
    AutoRoute(page: PersonalInfoPage, path: "/personal-info"),
    AutoRoute(page: AccountSettingPage, path: "/account-settings"),
    AutoRoute(page: CommunicationSettingPage, path: "/communication-settings"),
    AutoRoute(page: ForgetPasswordPage, path: "/forget-password"),
    AutoRoute(page: DeleteAccountPage, path: "/delete-account"),
    AutoRoute(page: FriendsFamilyPage, path: "/friends-family"),
    AutoRoute(page: MemberCardsPage, path: "/member-cards"),
    AutoRoute(page: MoreOptionsPage, path: "/more-options"),
    AutoRoute(page: LanguagePage, path: "/language"),
    AutoRoute(page: ManageBookingDetailsPage, path: "/manage-booking-details"),
    AutoRoute(page: NewTravelDatesPage, path: "/new-travel-dates"),
    AutoRoute(page: SelectChangeFlightPage, path: "/select-change-flight"),
    AutoRoute(page: ChangeFlightSummaryPage, path: "/change-flight-summary"),
    AutoRoute(
        page: ChangeFlightConfirmationPage,
        path: "/change-flight-confirmation"),

//
  ],
)
class AppRouter extends _$AppRouter {}
