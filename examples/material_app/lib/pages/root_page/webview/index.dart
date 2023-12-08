import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class WebviewRootPage extends StatefulWidget {
  const WebviewRootPage({super.key});

  @override
  State<WebviewRootPage> createState() => _UtilRootPageState();
}

class _UtilRootPageState extends State<WebviewRootPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return const WebviewPage(
      title: 'Webview页面',
      url: 'https://www.bing.com',
      enableNavIntercept: true,
    );
  }
}
