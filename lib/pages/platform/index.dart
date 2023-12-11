import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

export 'root_page.dart';

class MyPlatformApp extends StatelessWidget {
  const MyPlatformApp({
    super.key,
    required this.home,
    this.title,
    this.routePageType = RoutePageType.material,
    this.materialTheme,
    this.cupertinoTheme,
  });

  final Widget home;
  final String? title;

  /// 路由跳转动画类型，仅针对android平台，ios必须为cupertino
  final RoutePageType routePageType;
  final ThemeData? materialTheme;
  final CupertinoThemeData? cupertinoTheme;

  @override
  Widget build(BuildContext context) {
    RouterUtil.routePageType =
        CommonUtil.isApplePlatform ? RoutePageType.cupertino : routePageType;
    return PlatformApp(
      title: title ?? 'Platform App',
      material: (context, platform) => MaterialAppData(
        theme: materialTheme,
      ),
      cupertino: (context, platform) => CupertinoAppData(
        theme: cupertinoTheme,
      ),
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
      home: home,
      builder: builderMyApp(),
    );
  }
}
