import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// flutter官方webview，官方的很简陋，建议使用flutter_inappwebview实现的webview
class WebviewWidget2 extends StatefulWidget {
  const WebviewWidget2({super.key, this.url, this.asset, this.html});

  final String? url;

  final String? asset;

  final String? html;

  @override
  State<WebviewWidget2> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget2> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    if (widget.url != null) {
      controller.loadRequest(Uri.parse(widget.url!));
    } else if (widget.asset != null) {
      controller.loadFlutterAsset(widget.asset!);
    } else if (widget.html != null) {
      controller.loadHtmlString(widget.html!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}

class WebviewPage2 extends StatefulWidget {
  const WebviewPage2({
    super.key,
    this.title,
    this.url,
    this.asset,
    this.html,
    this.enableFullScreen = false,
    this.focusLandscape = false,
    this.clearCache = false,
  });

  /// 指定页面标题，如果没有则不显示appBar
  final String? title;

  final String? url;

  final String? asset;

  final String? html;

  /// 是否开启全屏
  final bool enableFullScreen;

  /// 是否强制横屏展示Webview
  final bool focusLandscape;

  /// 每次加载是否清除webview缓存
  final bool clearCache;

  @override
  State<WebviewPage2> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage2> {
  @override
  void initState() {
    super.initState();
    // 强制横屏
    if (widget.focusLandscape) {
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
      );
    }

    if (widget.enableFullScreen) {
      StatusBarControl.setFullscreen(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.focusLandscape) {
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
      );
    }

    if (widget.enableFullScreen) {
      StatusBarControl.setFullscreen(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title != null
          ? AppBar(
              title: Text(widget.title!),
            )
          : null,
      body: WebviewWidget2(
        url: widget.url,
        asset: widget.asset,
        html: widget.html,
      ),
    );
  }
}
