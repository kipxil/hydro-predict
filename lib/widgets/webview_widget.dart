import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../services/api_config.dart';

class WebViewWidgetWrapper extends StatefulWidget {
  const WebViewWidgetWrapper({super.key});

  @override
  State<WebViewWidgetWrapper> createState() => _WebViewWidgetWrapperState();
}

class _WebViewWidgetWrapperState extends State<WebViewWidgetWrapper> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(ApiConfig.baseUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
