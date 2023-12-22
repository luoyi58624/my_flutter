import 'package:flutter/material.dart';
import 'package:package/index.dart';

import 'router/controller.dart';
import 'router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  Get.put(RouterController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyApp.material3(
      router: router,
      theme: MyTheme.buildMaterial3ThemeData(
        primaryColor: primaryColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
