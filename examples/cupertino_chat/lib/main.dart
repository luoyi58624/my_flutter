import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino/index.dart';

import 'pages/root_page/index.dart';

void main() async {
  await initMyFlutter();
  runApp(
    MyCupertinoApp(
      home: const RootPage(),
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemGreen,
        textTheme: CupertinoTextThemeData(
          textStyle: const TextStyle(
            color: CupertinoDynamicColor.withBrightness(
                color: Color(0xFF222222), darkColor: Color(0xFFffffff)),
            fontWeight: FontWeight.w500,
          ),
          navActionTextStyle: const CupertinoThemeData()
              .textTheme
              .navActionTextStyle
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    ),
  );
}
