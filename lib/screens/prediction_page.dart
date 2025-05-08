import 'package:flutter/material.dart';
import '../widgets/webview_widget.dart';

class PredictionPage extends StatelessWidget {
  const PredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Stream & Prediksi")),
      body: const WebViewWidgetWrapper(),
    );
  }
}