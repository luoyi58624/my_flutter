import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'my_flutter.dart';

enum AppType {
  material,
  cupertino,
}

late AppType appType;

class MyApp extends StatelessWidget {
  /// 构建flutter默认风格的App：MaterialApp
  const MyApp(
    this.router, {
    super.key,
    this.title = '',
    this.home,
    this.rootPages,
    this.theme,
    this.darkTheme,
  })  : _appType = AppType.material,
        cupertinoTheme = null;

  /// 构建ios风格的App
  const MyApp.cupertino(
    this.router, {
    super.key,
    this.title = '',
    this.home,
    this.rootPages,
    this.cupertinoTheme,
  })  : _appType = AppType.cupertino,
        theme = null,
        darkTheme = null;

  final AppType _appType;

  /// go_router实例
  final GoRouter router;

  /// App标题，默认空
  final String title;

  /// 首页组件，注意：home和rootPages必须二选一
  final Widget? home;

  /// 根页面数组，length>=2，注意：home和rootPages必须二选一
  final List<RootPageModel>? rootPages;

  /// material亮色主题，默认使用 buildMaterialThemeData 方法构建
  final ThemeData? theme;

  /// material黑暗主题，默认不启用
  final ThemeData? darkTheme;

  /// ios主题
  final CupertinoThemeData? cupertinoTheme;

  @override
  Widget build(BuildContext context) {
    appType = _appType;
    switch (_appType) {
      case AppType.material:
        return MaterialApp.router(
          title: title,
          theme: theme ?? buildMaterialThemeData(),
          darkTheme: darkTheme,
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
