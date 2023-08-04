import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart'; // Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

class License extends StatelessWidget {
  final Uri? uri;
  final WebViewController _controller;

  License({super.key, this.uri})
      : _controller = WebViewController.fromPlatformCreationParams(
            PlatformWebViewControllerCreationParams())
          ..loadRequest(
              uri ?? Uri(scheme: "https", host: "codde-pi.com", path: "cgu"));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: WebViewWidget(controller: _controller),
      ),
    );
  }
}
