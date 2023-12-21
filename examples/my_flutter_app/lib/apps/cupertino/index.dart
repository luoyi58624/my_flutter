import 'package:flutter/cupertino.dart';
import 'package:package/index.dart';

import 'pages/root_page.dart';

class MyCupertinoApp extends StatelessWidget {
  const MyCupertinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyApp.cupertino(
      home: RootPage(),
      primaryColor: CupertinoColors.systemGreen,
    );
  }
}
