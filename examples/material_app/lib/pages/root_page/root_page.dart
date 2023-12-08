import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/material/index.dart';

import 'home/index.dart';
import 'util/index.dart';
import 'example/index.dart';
import 'template/index.dart';
import 'webview/index.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      pages: const [
        RootPageModel('首页', HomeRootPage(), Icons.home),
        RootPageModel('组件', UtilRootPage(), Icons.token_outlined),
        RootPageModel('模版', TemplateRootPage(), Icons.temple_hindu),
        RootPageModel('示例', ExampleRootPage(), Icons.book),
        RootPageModel('网页', WebviewRootPage(), Icons.inbox),
      ],
    );
  }
}
