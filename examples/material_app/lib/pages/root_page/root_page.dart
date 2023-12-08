import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/material/index.dart';

import 'component/index.dart';
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
        RootPageModel('组件', ComponentRootPage(), Icons.home),
        RootPageModel('工具', UtilRootPage(), Icons.token_outlined),
        RootPageModel('网页', WebviewRootPage(), Icons.inbox),
        RootPageModel('模版', TemplateRootPage(), Icons.temple_hindu),
        RootPageModel('示例', ExampleRootPage(), Icons.book),
      ],
    );
  }
}
