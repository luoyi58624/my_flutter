import 'package:flutter/material.dart';
import 'package:material_app/controller/global_controller.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/material/index.dart';

import 'home/index.dart';
import 'util/index.dart';
import 'example/index.dart';
import 'template/index.dart';

class RootPage extends GetView<GlobalController> {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => MaterialRootPage(
          useMaterial3NavigationBar: true,
          pages: [
            RootPageModel(
              '首页',
              const HomeRootPage(),
              icon: Icons.home,
              badge: controller.homeBadge.value,
            ),
            const RootPageModel(
              '组件',
              UtilRootPage(),
              icon: Icons.token_outlined,
            ),
            const RootPageModel(
              '模版',
              TemplateRootPage(),
              icon: Icons.temple_hindu,
            ),
            const RootPageModel(
              '示例',
              ExampleRootPage(),
              icon: Icons.book,
            ),
          ],
        ));
  }
}
