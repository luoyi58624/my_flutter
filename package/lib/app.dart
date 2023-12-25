import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package/index.dart';

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
    this.useMaterial3 = true,
    this.theme,
    this.darkTheme,
    this.onGenerateRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.localizationsDelegates,
    this.supportedLocales,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.translucenceStatusBar = true,
    this.locale = const Locale('zh', 'CN'),
  }) : router = null;

  const MyApp.router({
    super.key,
    this.title = '',
    required this.router,
    this.useMaterial3 = true,
    this.theme,
    this.darkTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.translucenceStatusBar = true,
    this.locale = const Locale('zh', 'CN'),
  })  : home = null,
        onGenerateRoute = null,
        navigatorObservers = const <NavigatorObserver>[];

  /// App标题，默认空
  final String title;

  /// App首屏页面，注意：此选项建议用于简单App，复杂App请使用router参数
  final Widget? home;

  /// 基于[GoRouter]的router配置，支持(路由拦截、深度链接、命名路由)等功能
  final GoRouter? router;

  /// 是否开启material3主题，flutter3.16版本后默认为true
  final bool useMaterial3;

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

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  /// material2主题是否显示半透明状态栏
  final bool translucenceStatusBar;

  ThemeController get themeController => Get.find();

  @override
  Widget build(BuildContext context) {
    themeController.appType.value = AppType.material.name;
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
    return Obx(() {
      return themeController.useMaterial3.value
          ? buildMaterial3App(
              context,
              localizationsDelegates: $localizationsDelegates,
              supportedLocales: $supportedLocales,
            )
          : buildMaterial2App(
              context,
              localizationsDelegates: $localizationsDelegates,
              supportedLocales: $supportedLocales,
            );
    });
  }

  Widget buildMaterial2App(
    BuildContext context, {
    required Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required Iterable<Locale> supportedLocales,
  }) {
    translucenceStatusBar ? themeController.showTranslucenceStatusBar() : themeController.hideTranslucenceStatusBar();
    final defaultTheme =
        themeController.buildMaterial2ThemeData(brightness: themeController.useDark.value ? Brightness.dark : Brightness.light);
    if (home != null) {
      return MaterialApp(
        title: title,
        theme: theme ?? defaultTheme,
        darkTheme: darkTheme ?? themeController.buildMaterial2ThemeData(brightness: Brightness.dark),
        home: home,
        onGenerateRoute: onGenerateRoute,
        navigatorObservers: navigatorObservers,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    } else {
      return MaterialApp.router(
        title: title,
        theme: theme ?? defaultTheme,
        darkTheme: darkTheme ?? themeController.buildMaterial2ThemeData(brightness: Brightness.dark),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    }
  }

  Widget buildMaterial3App(
    BuildContext context, {
    required Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required Iterable<Locale> supportedLocales,
  }) {
    themeController.hideTranslucenceStatusBar();
    final defaultTheme =
        themeController.buildMaterial3ThemeData(brightness: themeController.useDark.value ? Brightness.dark : Brightness.light);
    if (home != null) {
      return MaterialApp(
        title: title,
        theme: theme ?? defaultTheme,
        darkTheme: darkTheme ?? themeController.buildMaterial3ThemeData(brightness: Brightness.dark),
        home: home,
        onGenerateRoute: onGenerateRoute,
        navigatorObservers: navigatorObservers,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    } else {
      return MaterialApp.router(
        title: title,
        theme: theme ?? defaultTheme,
        darkTheme: darkTheme ?? themeController.buildMaterial3ThemeData(brightness: Brightness.dark),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    }
  }
}

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({
    super.key,
    required this.home,
    this.title = '',
    this.cupertinoTheme,
    this.onGenerateRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.localizationsDelegates,
    this.supportedLocales,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.locale = const Locale('zh', 'CN'),
  }) : router = null;

  const MyCupertinoApp.router({
    super.key,
    required this.router,
    this.title = '',
    this.cupertinoTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.locale = const Locale('zh', 'CN'),
  })  : home = null,
        onGenerateRoute = null,
        navigatorObservers = const <NavigatorObserver>[];

  /// App标题，默认空
  final String title;

  /// App首屏页面，注意：此选项建议用于简单App，复杂App请使用router参数
  final Widget? home;

  /// 基于[GoRouter]的router配置，支持(路由拦截、深度链接、命名路由)等功能
  final GoRouter? router;

  /// ios主题
  final CupertinoThemeData? cupertinoTheme;

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

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  ThemeController get themeController => Get.find();

  @override
  Widget build(BuildContext context) {
    themeController.appType.value = AppType.cupertino.name;
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
    return Obx(() {
      return buildCupertinoApp(
        context,
        localizationsDelegates: $localizationsDelegates,
        supportedLocales: $supportedLocales,
      );
    });
  }

  Widget buildCupertinoApp(
    BuildContext context, {
    required Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required Iterable<Locale> supportedLocales,
  }) {
    themeController.hideTranslucenceStatusBar();
    final defaultTheme =
        themeController.buildCupertinoTheme(brightness: themeController.useDark.value ? Brightness.dark : Brightness.light);
    if (home != null) {
      return CupertinoApp(
        title: title,
        theme: cupertinoTheme ?? defaultTheme,
        home: home,
        onGenerateRoute: onGenerateRoute,
        navigatorObservers: navigatorObservers,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    } else {
      return CupertinoApp.router(
        title: title,
        theme: cupertinoTheme ?? defaultTheme,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    }
  }
}

/// MaterialApp、CupertinoApp的 builder 参数，初始化全局toast、解决modal_bottom_sheet在高版本安卓系统上动画丢失问题
TransitionBuilder initBuilder() => (context, child) {
      globalContext ??= context;
      if (globalContext != context) {
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
