import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/material/index.dart';

import 'pages/root_page/root_page.dart';

void main() async {
  await initMyFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyMaterialApp(
      useMaterial3: false,
      primaryColor: ColorUtil.createMaterialColor(
          const Color.fromARGB(255, 16, 185, 129)),
      showTranslucenceStatusBar: true,
      home: const RootPage(),
    );
  }
}
