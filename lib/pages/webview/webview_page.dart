import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ui/navigation_controls.dart';
import 'ui/web_view_stack.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewPage({Key? key, required this.url, this.title})
      : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title == null
          ? null
          : AppBar(
              title: Text(widget.title!),
              actions: [
                NavigationControls(controller: controller),
                //Menu(controller: controller),
              ],
              centerTitle: false,
            ),
      body: widget.title == null
          ? SafeArea(
              child: WebViewStack(
                controller: controller,
                url: widget.url,
              ),
            )
          : WebViewStack(
              controller: controller,
              url: widget.url,
            ),
    );
  }
}
