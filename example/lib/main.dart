import 'package:flutter/material.dart';

import 'hive_model/index.dart';
import 'plugins.dart';
import 'root_page/index.dart';

void main() async {
  await initMyFlutter();
  registerModelAdapter();
  runApp(const RestartAppWidget(child: _MyApp()));
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MyApp(
      darkTheme: myTheme.buildThemeData(brightness: Brightness.dark),
      home: const RootPage(
        pages: rootPages,
      ),
    );
  }
}
