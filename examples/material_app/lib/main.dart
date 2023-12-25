import 'package:flutter/material.dart';
import 'package:package/index.dart';

import 'root_page/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter(themeModel: const ThemeModel(useMaterial3: false, textBold: true));
  runApp(const RestartAppWidget(child: _MyApp()));
}

final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    createRootPage(materialRootPages),
  ],
);

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return MyApp(
        router: router,
      );
    });
  }
}
