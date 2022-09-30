import 'package:app/pages/home/home_page.dart';
import 'package:app/pages/inapp_webview/in_app_webview_page.dart';
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
    AutoRoute(page: WelcomePage, path: "/welcome"),
    AutoRoute(page: WebViewPage, path: "/webview"),
    AutoRoute(page: InAppWebViewPage, path: "/in-app-webview"),
  ],
)
class AppRouter extends _$AppRouter {}
