import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/router_report.dart';

import 'package:my_flutter/my_flutter.dart';

/// 第一次使用MyApp时创建的context，防止用户嵌套多个MyApp或其他顶级App时重复初始化某些内容，例如[globalNavigatorKey],[initBuilder]
BuildContext? _initContext;

/// 默认的国际化配置
const List<LocalizationsDelegate<dynamic>> _localizationsDelegates = [
  GlobalWidgetsLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

/// 默认支持的语言
const _supportedLocales = [
  Locale('zh', 'CH'),
  Locale('en', 'US'),
];

class MyApp extends StatelessWidget {
  /// 以[MaterialApp]构建应用程序
  const MyApp({
    super.key,
    this.title = '',
    this.home,
    this.theme,
    this.darkTheme,
    this.onGenerateRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.localizationsDelegates,
    this.supportedLocales,
    this.locale = const Locale('zh', 'CN'),
    this.fontFamily,
    this.builder,
  }) : assert((home != null && onGenerateRoute == null) || (home == null && onGenerateRoute != null), 'home和onGenerateRoute参数必须二选一');

  /// App标题，默认空
  final String title;

  /// 首屏页面
  final Widget? home;

  /// Material亮色主题
  final ThemeData? theme;

  /// 当设备设置为黑暗模式时App使用的主题，默认策略和flutter保持一致：[Brightness.light]。
  final ThemeData? darkTheme;

  /// 自定义生成首屏页，此选项一般用于拦截用户是否登录
  final RouteFactory? onGenerateRoute;

  /// 监听路由跳转
  final List<NavigatorObserver> navigatorObservers;

  /// 国际化配置，你传入的新配置将合并至默认配置，默认配置为：
  /// ```dart
  /// [
  ///  GlobalWidgetsLocalizations.delegate,
  ///  GlobalMaterialLocalizations.delegate,
  ///  GlobalCupertinoLocalizations.delegate,
  /// ]
  /// ```
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// 支持的语言数组，你传入的新配置将合并至默认配置，默认配置为：
  /// ```dart
  /// [
  ///   Locale('zh', 'CH'),
  ///   Locale('en', 'US'),
  /// ]
  final Iterable<Locale>? supportedLocales;

  /// 默认的语言，默认为：const Locale('zh', 'CN')
  final Locale locale;

  final String? fontFamily;

  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    var $localizationsDelegates = CommonUtil.concatArray((localizationsDelegates ?? []).toList(), _localizationsDelegates).map((e) => e);
    var $supportedLocales = CommonUtil.concatArray((supportedLocales ?? []).toList(), _supportedLocales).map((e) => e);
    return MaterialApp(
      title: title,
      onGenerateRoute: onGenerateRoute ??
          (setting) {
            return CupertinoPageRoute(builder: (context) => home!);
          },
      navigatorObservers: [...navigatorObservers, _GetXRouterObserver()],
      navigatorKey: globalNavigatorKey,
      theme: theme ?? myTheme.buildThemeData(fontFamily: fontFamily),
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: $localizationsDelegates,
      supportedLocales: $supportedLocales,
      locale: locale,
      builder: (context, child) {
        _initContext ??= context;
        if (_initContext != context) {
          return child!;
        } else {
          var textTheme = const CupertinoThemeData().textTheme;
          return Overlay(
            initialEntries: [
              OverlayEntry(builder: (context) {
                toast.init(context);
                return MediaQuery(
                  // 解决modal_bottom_sheet在高版本安卓系统上动画丢失
                  data: MediaQuery.of(context).copyWith(accessibleNavigation: false),
                  child: Material(
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        primaryColor: myTheme.primaryColor,
                        textTheme: CupertinoTextThemeData(
                          textStyle: textTheme.textStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontFamily: fontFamily,
                          ),
                          tabLabelTextStyle: textTheme.tabLabelTextStyle.copyWith(
                            fontSize: 12,
                            fontFamily: fontFamily,
                          ),
                          navActionTextStyle: textTheme.navActionTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            color: myTheme.primaryColor,
                            fontFamily: fontFamily,
                          ),
                        ),
                      ),
                      child: builder == null ? child! : builder!(context, child),
                    ),
                  ),
                );
              }),
            ],
          );
        }
      },
    );
  }
}

/// 监听路由变化，将路由添加到getx管理，实现离开页面自动销毁绑定的控制器。
/// 只有一点需要注意：Get.put在StatelessWidget中必须将放置build方法中，否则无法正确回收控制器。
///
/// 反例：
/// ```dart
/// class GetxDemoPage extends StatelessWidget {
///   GetxDemoPage({super.key});
///   final controller = Get.put(GetxDemoController());
///
///   @override
///   Widget build(BuildContext context) {
///     return Container();
///   }
/// }
/// ```
///
/// 正确做法：
/// ```dart
/// class GetxDemoPage extends StatelessWidget {
///   const GetxDemoPage({super.key});
///
///   @override
///   Widget build(BuildContext context) {
///     // Getx不会重复注入相同的控制器，所以不必担心此代码会影响程序的正常运行
///     final controller = Get.put(GetxDemoController());
///     return Container();
///   }
/// }
/// ```
class _GetXRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    RouterReportManager.instance.reportCurrentRoute(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    RouterReportManager.instance.reportRouteDispose(route);
  }
}
