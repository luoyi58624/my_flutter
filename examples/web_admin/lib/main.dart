import 'package:flutter/material.dart';
import 'package:package/index.dart';

import 'router/controller.dart';
import 'router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter(themeModel: const ThemeModel(useMaterial3: true));
  Get.put(RouterController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp(
      router: router,
      theme: ThemeController.of.buildMaterialThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}
