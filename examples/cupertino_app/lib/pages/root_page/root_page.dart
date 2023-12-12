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
        NavPageModel('组件', ComponentRootPage(), icon: CupertinoIcons.home),
        NavPageModel('工具', UtilRootPage(), icon: CupertinoIcons.settings_solid),
        NavPageModel('模版', TemplateRootPage(),
            icon: CupertinoIcons.list_bullet),
        NavPageModel('示例', ExampleRootPage(), icon: CupertinoIcons.book),
      ],
    );
  }
}
