import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

export 'root_page.dart';

class MyPlatformApp extends StatelessWidget {
  const MyPlatformApp({
    super.key,
    required this.home,
    this.title,
    this.materialTheme,
    this.cupertinoTheme,
  });

  final Widget home;
  final String? title;
  final ThemeData? materialTheme;
  final CupertinoThemeData? cupertinoTheme;

  @override
  Widget build(BuildContext context) {
    routePageType = CommonUtil.isApplePlatform
        ? RoutePageType.cupertino
        : RoutePageType.material;
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
