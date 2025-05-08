import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidgetWrapper extends StatefulWidget {
  const WebViewWidgetWrapper({super.key});

  @override
  State<WebViewWidgetWrapper> createState() => _WebViewWidgetWrapperState();
}

class _WebViewWidgetWrapperState extends State<WebViewWidgetWrapper> {
  final String baseUrl = 'http://192.168.245.168:5000'; // Ganti dengan IP Raspberry Pi
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(baseUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
