import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package/index.dart';

/// 第一次使用MyApp时创建的context，防止用户嵌套多个MyApp或其他顶级App时重复初始化某些内容，例如[rootNavigatorKey],[initBuilder]
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
    required this.router,
    this.theme,
    this.darkTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.translucenceStatusBar = true,
    this.locale = const Locale('zh', 'CN'),
  })  : _appType = AppType.material,
        cupertinoTheme = null;

  /// 以[CupertinoApp]构建应用程序
  const MyApp.cupertino({
    super.key,
    this.title = '',
    required this.router,
    this.cupertinoTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.translucenceStatusBar = true,
    this.locale = const Locale('zh', 'CN'),
  })  : _appType = AppType.cupertino,
        theme = null,
        darkTheme = null;

  final AppType _appType;

  /// App标题，默认空
  final String title;

  /// 基于[GoRouter]的router配置
  final GoRouter? router;

  /// Material亮色主题
  final ThemeData? theme;

  /// 当设备设置为黑暗模式时App使用的主题，默认策略和flutter保持一致：[Brightness.light]。
  ///
  /// 如果你需要为app适配黑暗模式，请指定[Brightness.dark]。
  ///
  /// 注意：如果你使用自定义theme，同时需要响应式更新Theme，请使用Obx进行包裹，否则你无法实现响应式更新Theme。
  ///
  /// 示例：
  /// ```dart
  /// Obx(() => MyApp(
  ///   router,
  ///   darkTheme: ThemeController.of.buildMaterialThemeData(
  ///     brightness: Brightness.dark,
  ///   ),
  /// ))
  /// ```
  final ThemeData? darkTheme;

  /// cupertino主题
  final CupertinoThemeData? cupertinoTheme;

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

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  /// material2主题是否显示半透明状态栏
  final bool translucenceStatusBar;

  ThemeController get themeController => Get.find();

  @override
  Widget build(BuildContext context) {
    themeController.appType.value = _appType.name;
    themeController.translucenceStatusBar.value = translucenceStatusBar;

    if (onlyHorizontalMode) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    if (onlyVerticalMode) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    var $localizationsDelegates = CommonUtil.concatArray((localizationsDelegates ?? []).toList(), _localizationsDelegates).map((e) => e);
    var $supportedLocales = CommonUtil.concatArray((supportedLocales ?? []).toList(), _supportedLocales).map((e) => e);
    switch (_appType) {
      case AppType.material:
        return MaterialApp.router(
          title: title,
          theme: theme ??
              themeController.buildMaterialThemeData(brightness: themeController.useDark.value ? Brightness.dark : Brightness.light),
          darkTheme: darkTheme,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: $localizationsDelegates,
          supportedLocales: $supportedLocales,
          locale: locale,
          builder: initBuilder(),
        );
      case AppType.cupertino:
        return CupertinoApp.router(
          title: title,
          theme: cupertinoTheme ??
              themeController.buildCupertinoTheme(brightness: themeController.useDark.value ? Brightness.dark : Brightness.light),
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: $localizationsDelegates,
          supportedLocales: $supportedLocales,
          locale: locale,
          builder: initBuilder(),
        );
      default:
        throw Exception('未知App - ${_appType.name}');
    }
  }
}

/// MaterialApp、CupertinoApp的 builder 参数，初始化全局toast、解决modal_bottom_sheet在高版本安卓系统上动画丢失问题
TransitionBuilder initBuilder() => (context, child) {
      _initContext ??= context;
      if (_initContext != context) {
        return child!;
      } else {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              toast.init(context);
              return MediaQuery(
                // 解决modal_bottom_sheet在高版本安卓系统上动画丢失
                data: MediaQuery.of(context).copyWith(accessibleNavigation: false),
                child: child!,
              );
            }),
          ],
        );
      }
    };
