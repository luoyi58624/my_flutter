import 'package:flutter/cupertino.dart';
import 'package:package/index.dart';

import 'pages/root_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  runApp(const MyApp.cupertino(
    home: RootPage(),
    primaryColor: CupertinoColors.systemGreen,
  ));
}
