import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

export 'root_page.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key, required this.home, this.title, this.theme});

  final Widget home;
  final String? title;
  final ThemeData? theme;

  @override
  Widget build(BuildContext context) {
    routePageType = RoutePageType.cupertino;
    return MaterialApp(
      title: title ?? 'Cupertino App',
      theme: theme,
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
