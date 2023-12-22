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
    this.router,
    this.theme,
    this.darkTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.bottomNavigationType,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.translucenceStatusBar = true,
    this.locale = const Locale('zh', 'CN'),
  })  : assert((home != null && router == null) || (home == null && router != null), 'home和router选项必须二选一'),
        _appType = AppType.material,
        textBold = true,
        cupertinoTheme = null;

  /// 以[CupertinoApp]构建应用程序
  const MyApp.cupertino({
    super.key,
    this.title = '',
    this.home,
    this.router,
    this.cupertinoTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.bottomNavigationType,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.locale = const Locale('zh', 'CN'),
  })  : assert((home != null && router == null) || (home == null && router != null), 'home和router选项必须二选一'),
        _appType = AppType.cupertino,
        theme = null,
        darkTheme = null,
        textBold = false,
        translucenceStatusBar = false;

  /// app类型
  final AppType _appType;

  /// App标题，默认空
  final String title;

  /// App首屏页面，注意：此选项建议用于简单App，复杂App请使用router参数
  final Widget? home;

  /// 基于[GoRouter]的router配置，支持(路由拦截、深度链接、命名路由)等功能
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

  /// ios主题
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

  /// 底部导航栏类型
  final BottomNavigationType? bottomNavigationType;

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  /// material2主题是否显示半透明状态栏
  final bool translucenceStatusBar;

  /// 文字是否全局加粗
  final bool textBold;

  ThemeController get themeController => Get.find();

  @override
  Widget build(BuildContext context) {
    themeController.appType.value = _appType.name;
    themeController.textBold.value = textBold;
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
      if (themeController.appType.value == AppType.material.name) {
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
      } else if (themeController.appType.value == AppType.cupertino.name) {
        return buildCupertinoApp(
          context,
          localizationsDelegates: $localizationsDelegates,
          supportedLocales: $supportedLocales,
        );
      } else {
        throw Exception('未知App类型');
      }
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
