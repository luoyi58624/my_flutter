import 'package:flutter/material.dart';
import 'package:package/index.dart';

class ComponentRootPage extends StatelessWidget {
  const ComponentRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('组件'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                RouterUtil.to(context, const _ChildPage());
              },
              child: const Text('子页面'),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/material/my');
              },
              child: const Text('切换-我的'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChildPage extends StatelessWidget {
  const _ChildPage();

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
