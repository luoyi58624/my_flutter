import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:my_flutter/my_flutter.dart';

export './cupertino/root_page.dart';

/// 重启app
void rebootApp(BuildContext context) {
  Phoenix.rebirth(context);
}

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({
    super.key,
    this.title = 'Cupertino App',
    required this.routes,
    this.theme,
    this.navigatorKey,
  });

  final String title;
  final CupertinoThemeData? theme;

  /// 基于go_router库的GoRoute数组
  final List<RouteBase> routes;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    logger.i('app build');
    routePageType = RoutePageType.cupertino;
    return Phoenix(
      child: CupertinoApp.router(
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
      ),
    );
  }
}
