import 'package:flutter/material.dart';
import 'package:package/index.dart';

import 'root_page/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter(themeModel: const ThemeModel(useMaterial3: false, textBold: true));
  runApp(const RestartAppWidget(child: _MyApp()));
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return const MyApp(
      home: RootPage(
        pages: materialRootPages,
      ),
    );
  }
}
