import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyWebviewWidget extends StatefulWidget {
  const MyWebviewWidget({
    super.key,
    this.url,
    this.html,
    this.windowId,
    this.showScrollbar = true,
    this.disabledCache = false,
    this.enableGestureRecognizers = false,
    this.gestureRecognizers,
    this.enableNavIntercept = false,
    this.enablePullToRefresh = false,
    this.pullToRefreshColor,
    this.onCreated,
    this.onMounted,
    this.onProgressChanged,
    this.onTitleChanged,
    this.onCreateWindow,
  }) : assert(
            (url != null && html == null && windowId == null) ||
                (html != null && url == null && windowId == null) ||
                (windowId != null && url == null && html == null),
            '注意，webview参数url、html、windowId必须三选一');

  /// 加载的网页地址，如果是http开头则走网络请求，否则将加载assets目录下静态html文件
  final String? url;

  /// 加载html字符串
  final String? html;

  /// 使用windowId创建webview，用于onCreateWindow事件
  final int? windowId;

  /// 是否显示滚动条，默认true
  final bool showScrollbar;

  /// 是否禁止webview缓存
  final bool disabledCache;

  /// 是否开启手势识别器，默认false；如果你将webview嵌套在一个滚动容器中，
  /// 同时webview也是一个可滚动页面，那么你应该将其设置为true，否则webview无法滚动
  final bool enableGestureRecognizers;

  /// 自定义webview页面允许的手势，默认使用所有手势。
  ///
  /// Factory(() => EagerGestureRecognizer()), // 所有手势
  ///
  /// Factory(() => HorizontalDragGestureRecognizer()), // 水平滑动手势
  ///
  /// Factory(() => VerticalDragGestureRecognizer()), // 垂直滑动手势
  ///
  /// Factory(() => ScaleGestureRecognizer()), // 缩放手势
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  /// 是否开启Webview页面的导航拦截，注意：IOS下无效，因为WillPopScope将导致IOS无法侧边返回
  final bool enableNavIntercept;

  /// 是否开启下拉刷新
  final bool enablePullToRefresh;

  /// 下拉刷新指示器颜色
  final Color? pullToRefreshColor;

  /// 网页加载进度
  final void Function(InAppWebViewController controller, int progress)?
      onProgressChanged;

  /// webview创建完成，你可以在这里添加JavaScript处理程序，供前端调用
  final void Function(InAppWebViewController controller)? onCreated;

  /// webview页面加载完成，你可以在这里执行JavaScript中的方法
  final void Function(InAppWebViewController controller, Uri? url)? onMounted;

  /// 跳转地址url变化
  final void Function(InAppWebViewController controller, String? title)?
      onTitleChanged;

  /// webview触发新窗口事件
  final Future<bool?> Function(InAppWebViewController controller,
      CreateWindowAction createWindowAction)? onCreateWindow;

  @override
  State<MyWebviewWidget> createState() => _MyWebviewWidgetState();
}

class _MyWebviewWidgetState extends State<MyWebviewWidget> {
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  bool isHttp = false;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    super.initState();
    if (widget.url != null) isHttp = widget.url!.startsWith('http');
    pullToRefreshController = kIsWeb || !widget.enablePullToRefresh
        ? null
        : PullToRefreshController(
            options: PullToRefreshOptions(
              color: widget.pullToRefreshColor,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: widget.url == null
          ? null
          : isHttp
              ? URLRequest(url: Uri.parse(widget.url!))
              : null,
      initialFile: widget.url == null
          ? null
          : isHttp
              ? null
              : widget.url,
      initialData: widget.html == null
          ? null
          : InAppWebViewInitialData(data: widget.html!),
      initialOptions: options,
      pullToRefreshController: pullToRefreshController,
      gestureRecognizers: widget.enableGestureRecognizers
          ? widget.gestureRecognizers ??
              {
                Factory(() => EagerGestureRecognizer()),
                // Factory(() => VerticalDragGestureRecognizer()),
              }
          : null,
      onWebViewCreated: (controller) async {
        webViewController = controller;
        if (widget.onCreated != null) {
          widget.onCreated!(controller);
        }
      },
      onLoadStop: (controller, url) async {
        pullToRefreshController?.endRefreshing();
        if (widget.onMounted != null) {
          widget.onMounted!(controller, url);
        }
      },
      onProgressChanged: (controller, progress) {
        if (widget.onProgressChanged != null) {
          widget.onProgressChanged!(controller, progress);
        }
        if (progress == 100) {
          pullToRefreshController?.endRefreshing();
        }
      },
      onTitleChanged: widget.onTitleChanged,
      onCreateWindow: widget.onCreateWindow,
    );
  }
}
