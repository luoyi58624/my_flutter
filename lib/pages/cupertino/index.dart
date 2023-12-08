import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/my_flutter.dart';

export 'root_page.dart';

class MyCupertinoApp extends StatelessWidget {
  /// Cupertino预设脚手架
  const MyCupertinoApp({
    super.key,
    required this.home,
    this.title,
    this.theme,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
  });

  final Widget home;
  final String? title;
  final CupertinoThemeData? theme;

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
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
    routePageType = RoutePageType.cupertino;
    return CupertinoApp(
      title: title ?? 'Cupertino App',
      theme: theme ?? myCupertinoTheme,
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

/// 自定义Cupertino全局默认样式
final myCupertinoTheme = CupertinoThemeData(
  primaryColor: const Color.fromARGB(255, 0, 120, 212),
  textTheme: CupertinoTextThemeData(
    // 通用文字样式
    textStyle: const CupertinoThemeData()
        .textTheme
        .textStyle
        .copyWith(fontWeight: FontWeight.w500),
    // 顶部导航文字样式
    navActionTextStyle: const CupertinoThemeData()
        .textTheme
        .navActionTextStyle
        .copyWith(fontWeight: FontWeight.w500),
    // 底部导航栏文字样式
    tabLabelTextStyle: const CupertinoThemeData()
        .textTheme
        .tabLabelTextStyle
        .copyWith(fontSize: 12),
  ),
);
