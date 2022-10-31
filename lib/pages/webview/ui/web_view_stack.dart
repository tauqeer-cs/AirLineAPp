import 'dart:async';
import 'dart:convert';
import 'package:app/app/app_flavor.dart';
import 'package:app/theme/styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewStack extends StatefulWidget {
  final String url;
  final String? htmlContent;

  const WebViewStack({
    required this.controller,
    Key? key,
    required this.url,
    this.htmlContent,
  }) : super(key: key);

  final Completer<WebViewController> controller;

  @override
  State<WebViewStack> createState() => _WebViewStackState();
}

class _WebViewStackState extends State<WebViewStack> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    print("widget ${widget.htmlContent}");
    print("url ${widget.url}");
    return Stack(
      children: [
        WebView(
          initialUrl: widget.htmlContent!=null ? 'about:blank':widget.url,
          onWebViewCreated: (webViewController) {
            widget.controller.complete(webViewController);
            if(widget.htmlContent!=null){
              _loadHtmlFromAssets(webViewController);
            }
          },
          onPageStarted: (url) {
            if(!mounted) return;
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            if(!mounted) return;

            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            if(!mounted) return;

            setState(() {
              loadingPercentage = 100;
            });
          },
          navigationDelegate: (navigation) {
            print("navigation url is ${navigation.url}");
            if(navigation.url.contains(AppFlavor.paymentRedirectUrl)){
              context.router.pop(navigation.url);
            }
            final host = Uri.parse(navigation.url).host;
            if (host.contains('youtube.com')) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Blocking navigation to $host',
                  ),
                ),
              );
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          javascriptMode: JavascriptMode.unrestricted,
          javascriptChannels: _createJavascriptChannels(context),
        ),
        if (loadingPercentage < 100)
          LinearProgressIndicator(
            value: loadingPercentage / 100.0,
            color: Styles.kPrimaryColor,
          ),
      ],
    );
  }

  _loadHtmlFromAssets(WebViewController webViewController) async {
    webViewController.loadUrl(
      Uri.dataFromString(widget.htmlContent ?? "",
              mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
          .toString(),
    );
  }

  Set<JavascriptChannel> _createJavascriptChannels(BuildContext context) {
    return {
      JavascriptChannel(
        name: 'SnackBar',
        onMessageReceived: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        },
      ),
    };
  }
}
