import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'controller/global_controller.dart';
import 'router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  runApp(
    const RestartAppWidget(
      child: _MyApp(),
    ),
  );
}

class _MyApp extends StatefulWidget {
  const _MyApp();

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  final GlobalController globalController = Get.put(GlobalController());

  @override
  void deactivate() {
    super.deactivate();
    Get.delete<GlobalController>();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => globalController.appType.value == AppType.material.value
        ? const _MyMaterialApp()
        : const _MyCupertinoApp());
  }
}

class _MyMaterialApp extends StatelessWidget {
  const _MyMaterialApp();

  @override
  Widget build(BuildContext context) {
    routePageType = RoutePageType.material;
    return MaterialApp.router(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      checkerboardRasterCacheImages: false,
      theme: ThemeData(
        platform: TargetPlatform.iOS,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      locale: const Locale('zh', 'CN'),
      routerConfig: GoRouter(
        routes: routes,
      ),
      builder: builderMyApp(),
    );
  }
}

class _MyCupertinoApp extends StatelessWidget {
  const _MyCupertinoApp();

  @override
  Widget build(BuildContext context) {
    routePageType = RoutePageType.cupertino;
    return CupertinoApp.router(
      title: 'Cupertino App',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
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
      routerConfig: GoRouter(
        routes: routes,
      ),
      builder: builderMyApp(),
    );
  }
}
