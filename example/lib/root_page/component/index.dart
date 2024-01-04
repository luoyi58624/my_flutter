import 'package:flutter/material.dart';

import '../../plugins.dart';
import 'image_test.dart';

class ComponentRootPage extends StatelessWidget {
  const ComponentRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<NavPageModel> customComponentItems = [
      const NavPageModel('Image图片组件', ImageTestPage()),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('组件列表'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildListSection(context, '自定义组件', customComponentItems),
          ],
        ),
      ),
    );
  }
}
