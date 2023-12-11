import 'package:flutter/material.dart';
import 'package:my_flutter_webview/my_flutter_webview.dart';

class WebviewRootPage extends StatefulWidget {
  const WebviewRootPage({super.key});

  @override
  State<WebviewRootPage> createState() => _UtilRootPageState();
}

class _UtilRootPageState extends State<WebviewRootPage> {
  @override
  Widget build(BuildContext context) {
    return const MyWebviewPage(
      title: 'Webview页面',
      url: 'https://www.bing.com',
    );
  }
}
