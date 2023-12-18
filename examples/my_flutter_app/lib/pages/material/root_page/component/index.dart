import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class ComponentRootPage extends StatelessWidget {
  const ComponentRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoggerUtil.i('component build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('组件'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/component/child');
                // context.go('/my/child');
                // RouterUtil.to(() => const _ChildPage());
              },
              child: const Text('子页面'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/my');
              },
              child: const Text('切换-我的'),
            ),
            Obx(() {
              return Switch(
                value: ThemeController.of.useMaterial3.value,
                onChanged: (bool value) {
                  ThemeController.of.useMaterial3.value = value;
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _ChildPage extends StatelessWidget {
  const _ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // context.go('/component/child');
            // RouterUtil.to(const ChildPage(title: '组件子页面'), context: context);
          },
          child: const Text('我的子页面'),
        ),
      ),
    );
  }
}
