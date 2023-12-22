import 'package:flutter/cupertino.dart';
import 'package:package/index.dart';

import 'pages/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  ThemeController.of.primaryColor.value = CupertinoColors.systemGreen;
  runApp(const MyApp.cupertino(
    home: RootPage(),
  ));
}
