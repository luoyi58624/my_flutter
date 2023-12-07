import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino/index.dart';

import 'pages/root_page/component/index.dart';
import 'pages/root_page/template/index.dart';
import 'pages/root_page/example/index.dart';

void main() async {
  await initMyFlutter();
  runApp(
    MyCupertinoApp(
      // theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoRootPage(
        pages: const [
          RootPageModel('组件', ComponentRootPage(), CupertinoIcons.home),
          RootPageModel('模版', TemplateRootPage(), CupertinoIcons.list_bullet),
          RootPageModel('示例', ExampleRootPage(), CupertinoIcons.book),
        ],
      ),
    ),
  );
}
