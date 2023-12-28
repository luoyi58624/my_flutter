import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:web_admin/layout/controller.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  // Get.put(LayoutController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(brightness: Brightness.light),
      routerConfig: router,
    );
  }
}
