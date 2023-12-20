import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package/index.dart';

enum AppType {
  material,
  cupertino,
}

/// 底部导航栏类型
enum BottomNavigationType {
  material2,
  material3,
  cupertino,
}

late AppType appType;

class MyApp extends StatelessWidget {
  /// 构建Android风格的App
  const MyApp(
    this.router, {
    super.key,
    this.title = '',
    this.theme,
    this.darkTheme,
    this.bottomNavigationType,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
  })  : _appType = AppType.material,
        cupertinoTheme = null;

  /// 构建IOS风格的App
  const MyApp.cupertino(
    this.router, {
    super.key,
    this.title = '',
    this.cupertinoTheme,
    this.bottomNavigationType,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
  })  : _appType = AppType.cupertino,
        theme = null,
        darkTheme = null;

  final AppType _appType;

  /// go_router实例
  final GoRouter router;

  /// App标题，默认空
  final String title;

  /// Material 亮色主题
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

  /// 底部导航栏类型
  final BottomNavigationType? bottomNavigationType;

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  @override
  Widget build(BuildContext context) {
    appType = _appType;
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
    switch (_appType) {
      case AppType.material:
        return Obx(() {
          return MaterialApp.router(
            title: title,
            theme: theme ?? ThemeController.of.buildMaterialThemeData(),
            darkTheme: darkTheme ?? ThemeController.of.buildMaterialThemeData(),
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              GlobalWidgetsLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('zh', 'CH'),
              Locale('en', 'US'),
            ],
            locale: const Locale('zh', 'CN'),
            builder: builderMyApp(),
          );
        });
      case AppType.cupertino:
        return CupertinoApp.router(
          title: title,
          theme: cupertinoTheme,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('zh', 'CH'),
            Locale('en', 'US'),
          ],
          locale: const Locale('zh', 'CN'),
          builder: builderMyApp(),
        );
    }
  }
}
