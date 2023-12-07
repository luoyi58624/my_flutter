import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino/index.dart';

import 'pages/root_page/index.dart';

void main() async {
  await initMyFlutter();
  runApp(const MyCupertinoApp(
    home: RootPage(),
    theme: CupertinoThemeData(
      primaryColor: CupertinoColors.systemGreen,
    ),
  ));
}
