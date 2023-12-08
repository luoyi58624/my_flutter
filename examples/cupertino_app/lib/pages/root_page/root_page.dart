import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino/index.dart';

import 'component/index.dart';
import 'util/index.dart';
import 'example/index.dart';
import 'template/index.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoRootPage(
      pages: const [
        RootPageModel('组件', ComponentRootPage(), CupertinoIcons.home),
        RootPageModel('工具', UtilRootPage(), CupertinoIcons.settings_solid),
        RootPageModel('模版', TemplateRootPage(), CupertinoIcons.list_bullet),
        RootPageModel('示例', ExampleRootPage(), CupertinoIcons.book),
      ],
    );
  }
}
