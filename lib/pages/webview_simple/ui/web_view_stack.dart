import 'dart:async';

import 'package:app/app/app_flavor.dart';
import 'package:app/theme/styles.dart';
import 'package:app/widgets/app_app_bar.dart';
import 'package:app/widgets/app_logo_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStackSimple extends StatefulWidget {
  final String url;
  final String? htmlContent;

  const WebViewStackSimple({
    required this.controller,
    Key? key,
    required this.url,
    this.htmlContent,
  }) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<WebViewStackSimple> createState() => _WebViewStackSimpleState();
}

class _WebViewStackSimpleState extends State<WebViewStackSimple> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebView(
          initialUrl: "${AppFlavor.websiteUrl}${widget.url}",
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
          },
          onPageStarted: (url) {
            if (!mounted) return;
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) async{
            if (!mounted) return;
            setState(() {
              loadingPercentage = progress;
            });

          },
          onPageFinished: (url) async {
            if (!mounted) return;
            if (widget.controller.isCompleted) {
              print("page is finished");
              await Future.delayed(Duration(milliseconds: 399));
              final controller = await widget.controller.future;
              controller.runJavascript(
                  'document.querySelectorAll(".v-toolbar").forEach(el => el.remove());');
              controller.runJavascript(
                  'document.querySelectorAll(".v-footer").forEach(el => el.remove());');

            }
            setState(() {
              loadingPercentage = 100;
            });
          },
          navigationDelegate: (navigation) {
            context.router.pop();
            return NavigationDecision.prevent;
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
        // SafeArea(
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //     child: Row(
        //       children: [
        //         InkWell(
        //           onTap: () => context.router.pop(),
        //           child: Icon(
        //             Icons.chevron_left,
        //             size: 35,
        //             color: Styles.kPrimaryColor,
        //           ),
        //         ),
        //         Expanded(
        //           child: AppLogoWidget(
        //             height: 40.h,
        //             width: 120.w,
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
            color: Styles.kPrimaryColor,
          ),
      ],
    );
  }
}
