import 'dart:async';

import 'package:app/widgets/app_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ui/navigation_controls.dart';
import 'ui/web_view_stack.dart';

class WebViewSimplePage extends StatefulWidget {
  final String url;

  const WebViewSimplePage({Key? key, required this.url})
      : super(key: key);

  @override
  State<WebViewSimplePage> createState() => _WebViewSimplePageState();
}

class _WebViewSimplePageState extends State<WebViewSimplePage> {
  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        height: 60,

      ),
      body: WebViewStackSimple(
        controller: controller,
        url: widget.url,
      ),
    );
  }
}
