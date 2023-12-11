import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebviewPage extends StatefulWidget {
  const MyWebviewPage({super.key});

  @override
  State<MyWebviewPage> createState() => _MyWebviewPageState();
}

class _MyWebviewPageState extends State<MyWebviewPage> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webview'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: WebUri("https://www.bing.com")),
      ),
    );
  }
}
