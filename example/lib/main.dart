import 'package:flutter/material.dart';

import 'plugins.dart';
import 'root_page/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter(themeModel: ThemeModel(primaryColor: Colors.blue));
  runApp(const RestartAppWidget(child: _MyApp()));
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MyApp(
      fontFamily: 'NotoSansSC',
      darkTheme: myTheme.buildThemeData(brightness: Brightness.dark),
      home: const RootPage(
        pages: rootPages,
      ),
    );
  }
}
