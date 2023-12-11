import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewWidget extends StatefulWidget {
  const WebviewWidget({super.key, this.url, this.asset, this.html});

  final String? url;

  final String? asset;

  final String? html;

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> {
  late WebViewController controller;

  @override
  void initState() {
    GetPlatform.isIOS;
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
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return true;
        }
      },
      child: WebViewWidget(controller: controller),
    );
  }
}

class WebviewPage extends StatefulWidget {
  const WebviewPage({
    super.key,
    this.title,
    this.url,
    this.asset,
    this.html,
    this.enableFullScreen = false,
    this.enableNavIntercept = false,
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

  /// 是否返回拦截
  final bool enableNavIntercept;

  /// 是否强制横屏展示Webview
  final bool focusLandscape;

  /// 每次加载是否清除webview缓存
  final bool clearCache;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
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
              elevation: 1,
              backgroundColor: ColorUtil.dynamicColor(
                  const Color(0xFFFFFFFF), const Color(0xFF222222), context),
              titleTextStyle:
                  Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                        color: ColorUtil.dynamicColor(
                          const Color(0xFF333333),
                          const Color(0xFFFFFFFF),
                          context,
                        ),
                      ),
              iconTheme: IconThemeData(
                color: ColorUtil.dynamicColor(
                  const Color(0xFF333333),
                  const Color(0xFFFFFFFF),
                  context,
                ),
              ),
            )
          : null,
      body: WebviewWidget(
        url: widget.url,
        asset: widget.asset,
        html: widget.html,
      ),
    );
  }
}
