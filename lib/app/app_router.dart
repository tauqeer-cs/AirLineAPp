import 'package:app/pages/checkout/pages/booking_confirmation/booking_confirmation_page.dart';
import 'package:app/pages/checkout/pages/booking_details/booking_details.dart';
import 'package:app/pages/checkout/pages/booking_list/booking_list_page.dart';
import 'package:app/pages/checkout/pages/checkout/checkout_page.dart';
import 'package:app/pages/checkout/pages/payment/payment_page.dart';
import 'package:app/pages/checkout/pages/select_baggage/select_baggage_page.dart';
import 'package:app/pages/checkout/pages/select_bundle/select_bundle_page.dart';
import 'package:app/pages/checkout/pages/select_meals/select_meals_page.dart';
import 'package:app/pages/checkout/pages/select_seats/select_seats_page.dart';
import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/inapp_webview/in_app_webview_page.dart';
import 'package:app/pages/search_result/search_result_page.dart';
import 'package:app/pages/webview/webview_page.dart';
import 'package:app/pages/welcome/welcome_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
part 'app_router.gr.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true, path: "/home"),
    AutoRoute(page: SearchResultPage, initial: true, path: "/flight"),
    AutoRoute(page: WelcomePage, path: "/welcome"),
    AutoRoute(page: WebViewPage, path: "/webview"),
    AutoRoute(page: InAppWebViewPage, path: "/in-app-webview"),
    AutoRoute(page: SelectBundlePage, path: "/flight/addon/bundle"),
    AutoRoute(page: SelectSeatsPage, path: "/flight/addon/seat"),
    AutoRoute(page: SelectMealsPage, path: "/flight/addon/meal"),
    AutoRoute(page: SelectBaggagePage, path: "/flight/addon/baggage"),
    AutoRoute(page: BookingDetailsPage, path: "/booking-details"),
    AutoRoute(page: CheckoutPage, path: "/checkout"),
    AutoRoute(page: PaymentPage, path: "/payment"),
    AutoRoute(page: BookingListPage, path: "/booking-list"),
    AutoRoute(page: BookingConfirmationPage, path: "/booking-confirmation/:id"),
  ],
)
class AppRouter extends _$AppRouter {}
