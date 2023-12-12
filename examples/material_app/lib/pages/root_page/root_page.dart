import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/material/index.dart';

import 'home/index.dart';
import 'util/index.dart';
import 'example/index.dart';
import 'template/index.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialRootPage(
      useMaterial2NavigationBar: true,
      pages: const [
        NavPageModel('首页', HomeRootPage(), icon: Icons.home),
        NavPageModel('组件', UtilRootPage(), icon: Icons.token_outlined),
        NavPageModel('模版', TemplateRootPage(), icon: Icons.temple_hindu),
        NavPageModel('示例', ExampleRootPage(), icon: Icons.book),
      ],
    );
  }
}
