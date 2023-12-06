import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_flutter/my_flutter.dart';

export './cupertino/root_page.dart';

/// 运行IOS主题App
Future<void> runCupertinoApp({
  String title = 'Cupertino App',
  CupertinoThemeData? theme,
  required List<RouteBase> routes, // 必须传入基于go_router库的GoRoute数组
  GlobalKey<NavigatorState>? navigatorKey,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  routePageType = RoutePageType.cupertino;
  runApp(
    _CupertinoApp(title, routes, theme: theme, navigatorKey: navigatorKey),
  );
}

class _CupertinoApp extends StatelessWidget {
  const _CupertinoApp(
    this.title,
    this.routes, {
    this.theme,
    this.navigatorKey,
  });

  final String title;
  final CupertinoThemeData? theme;
  final List<RouteBase> routes;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      title: title,
      theme: theme,
      routerConfig: GoRouter(
        navigatorKey: navigatorKey,
        routes: routes,
      ),
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MyRootWidget(child: child!),
    );
  }
}
