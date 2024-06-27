import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Donation extends StatelessWidget {
  final WebViewController _controller =
      WebViewController.fromPlatformCreationParams(
          const PlatformWebViewControllerCreationParams())
        ..loadRequest(Uri(
            scheme: "https",
            host: "patreon.com",
            path: "user",
            query: "u=95462777"));

  Donation({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(), body: WebViewWidget(controller: _controller));
  }
}
