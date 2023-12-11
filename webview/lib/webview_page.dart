import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:my_flutter/my_flutter.dart';

import 'webview_widget.dart';

/// 通用的webview页面，它使用material头部样式，如果需要ios风格的webview页面，你可以使用CupertinoWebviewPage
class WebviewPage extends StatefulWidget {
  const WebviewPage({
    super.key,
    this.title,
    this.url,
    this.html,
    this.windowId,
    this.clearCache = false,
    this.showAppbar = true,
    this.showToolbar = true,
    this.enableProgressIndicator = true,
    this.enableFullScreen = false,
    this.elevation,
    this.headerBackground,
    this.headerColor,
    this.indicatorColor,
    this.focusLandscape = false,
    this.enableNavIntercept = false,
    this.enablePullToRefresh = false,
    this.onCreated,
    this.onMounted,
  });

  /// 指定页面标题
  final String? title;

  /// 加载的网页地址，如果是http开头则走网络请求，否则将加载assets目录
  final String? url;

  /// 加载html字符串
  final String? html;

  /// 使用windowId创建webview，一般用于onCreateWindow事件
  final int? windowId;

  /// 是否清除webview缓存
  final bool clearCache;

  /// 是否显示应用头部导航，若为false，则导航头和状态栏都消失
  final bool showAppbar;

  /// 是否显示工具栏，若为false，则导航头消失，只保留状态栏
  final bool showToolbar;

  /// 是否开启网页加载进度
  final bool enableProgressIndicator;

  /// 是否开启全屏
  final bool enableFullScreen;

  /// 应用头部导航海拔层级
  final double? elevation;

  /// 头部背景颜色，默认从 Theme.of 中获取
  final Color? headerBackground;

  /// 头部内容颜色，默认根据背景色自动匹配白色和黑色
  final Color? headerColor;

  /// 进度指示器颜色
  final Color? indicatorColor;

  /// 是否强制横屏展示Webview
  final bool focusLandscape;

  /// 是否开启Webview页面的导航拦截，注意：IOS下无效，因为WillPopScope将导致IOS无法返回
  final bool enableNavIntercept;

  /// 是否开启下拉刷新
  final bool enablePullToRefresh;

  /// webview创建完成，你可以在这里添加JavaScript处理程序，供前端调用
  final void Function(InAppWebViewController controller)? onCreated;

  /// webview加载完成，你可以在这里执行JavaScript中的方法
  final void Function(InAppWebViewController controller, Uri? url)? onMounted;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  InAppWebViewController? webViewController;
  String? webviewTitle; // 网页标题
  double progress = 0;

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
    Color headerBackground =
        widget.headerBackground ?? Theme.of(context).colorScheme.primary;
    Color headerColor = widget.headerColor ??
        (ColorUtil.isDark(headerBackground)
            ? Colors.white
            : Colors.grey.shade800);
    return Scaffold(
      appBar: widget.showAppbar
          ? AppBar(
              title: Tooltip(
                message: widget.title ?? webviewTitle ?? '',
                child: Text(widget.title ?? webviewTitle ?? ''),
              ),
              toolbarHeight: widget.showToolbar
                  ? Theme.of(context).appBarTheme.toolbarHeight
                  : 0,
              elevation: widget.elevation,
              backgroundColor: headerBackground,
              systemOverlayStyle: ColorUtil.isDark(headerBackground)
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: headerColor,
              ),
              iconTheme: IconThemeData(
                color: headerColor,
              ),
            )
          : null,
      body: buildWebview(),
    );
  }

  Widget buildWebview() {
    return Stack(
      children: [
        MyWebviewWidget(
          url: widget.url,
          html: widget.html,
          windowId: widget.windowId,
          enableNavIntercept: widget.enableNavIntercept,
          enablePullToRefresh: widget.enablePullToRefresh,
          onCreated: (controller) {
            webViewController = controller;
            if (widget.onCreated != null) {
              widget.onCreated!(controller);
            }
          },
          onMounted: widget.onMounted,
          onProgressChanged: (controller, progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
          onTitleChanged: (controller, title) {
            setState(() {
              webviewTitle = title;
            });
          },
          onCreateWindow: (controller, createWindowAction) async {
            RouterUtil.to(
              WebviewPage(
                windowId: createWindowAction.windowId,
                enableNavIntercept: widget.enableNavIntercept,
                enablePullToRefresh: widget.enablePullToRefresh,
                enableProgressIndicator: widget.enableProgressIndicator,
                onCreated: widget.onCreated,
              ),
            );
            return true;
          },
        ),
        if (widget.enableProgressIndicator)
          progress < 1.0
              ? LinearProgressIndicator(
                  value: progress,
                  minHeight: 2,
                  backgroundColor: Colors.transparent,
                  color: widget.indicatorColor ??
                      Theme.of(context).colorScheme.secondary,
                )
              : const SizedBox(),
      ],
    );
  }
}

/// IOS导航栏webview
class CupertinoWebviewPage extends StatefulWidget {
  const CupertinoWebviewPage({
    super.key,
    this.title,
    this.url,
    this.html,
    this.previousPageTitle = '返回',
    this.showAppbar = true,
    this.enableProgressIndicator = false,
    this.enableFullScreen = false,
    this.headerBackground,
    this.headerColor,
    this.focusLandscape = false,
    this.enableNavIntercept = false,
    this.enablePullToRefresh = false,
    this.onCreated,
    this.onMounted,
  });

  /// 指定页面标题
  final String? title;

  /// 加载的网页地址，如果是http开头则走网络请求，否则将加载assets目录
  final String? url;

  /// 加载html字符串
  final String? html;

  /// 返回文字
  final String previousPageTitle;

  /// 是否显示应用头部导航，若为false，则导航头和状态栏都消失
  final bool showAppbar;

  /// 是否开启网页加载进度
  final bool enableProgressIndicator;

  /// 是否开启全屏
  final bool enableFullScreen;

  /// 头部背景颜色，默认从 Theme.of 中获取
  final Color? headerBackground;

  /// 头部内容颜色，默认根据背景色自动匹配白色和黑色
  final Color? headerColor;

  /// 是否强制横屏展示Webview
  final bool focusLandscape;

  /// 是否开启Webview页面的导航拦截，注意：IOS下无效，因为WillPopScope将导致IOS无法返回
  final bool enableNavIntercept;

  /// 是否开启下拉刷新
  final bool enablePullToRefresh;

  /// webview创建完成，你可以在这里添加JavaScript处理程序，供前端调用
  final void Function(InAppWebViewController controller)? onCreated;

  /// webview加载完成，你可以在这里执行JavaScript中的方法
  final void Function(InAppWebViewController controller, Uri? url)? onMounted;

  @override
  State<CupertinoWebviewPage> createState() => _CupertinoWebviewPageState();
}

class _CupertinoWebviewPageState extends State<CupertinoWebviewPage> {
  InAppWebViewController? webViewController;
  String? webviewTitle; // 网页标题
  double progress = 0;

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
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: [SystemUiOverlay.bottom]);
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
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color headerBackground = widget.headerBackground ??
        Theme.of(context).appBarTheme.backgroundColor ??
        Theme.of(context).primaryColor;
    Color headerColor = widget.headerColor ??
        (ColorUtil.isDark(headerBackground)
            ? Colors.white
            : Colors.grey.shade800);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          widget.title ?? webviewTitle ?? '',
          style: TextStyle(
            color: headerColor,
          ),
        ),
        previousPageTitle: widget.previousPageTitle,
        backgroundColor: headerBackground,
      ),
      child: SafeArea(child: buildWebview()),
    );
  }

  Widget buildWebview() {
    return Stack(
      children: [
        MyWebviewWidget(
          url: widget.url,
          html: widget.html,
          enableNavIntercept: widget.enableNavIntercept,
          enablePullToRefresh: widget.enablePullToRefresh,
          showScrollbar: false,
          onCreated: widget.onCreated,
          onMounted: widget.onMounted,
          onProgressChanged: (controller, progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
          onTitleChanged: (controller, title) {
            setState(() {
              webviewTitle = title;
            });
          },
        ),
        if (widget.enableProgressIndicator)
          progress < 1.0
              ? LinearProgressIndicator(
                  value: progress,
                  minHeight: 2,
                  backgroundColor: Colors.transparent,
                )
              : const SizedBox(),
      ],
    );
  }
}
