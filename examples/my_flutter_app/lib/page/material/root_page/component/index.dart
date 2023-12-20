import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter_app/model/user_model.dart';

import '../../../../controller/global_controller.dart';

class ComponentRootPage extends StatelessWidget {
  const ComponentRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('组件'),
        actions: [
          IconButton(
            onPressed: () {
              GlobalController.of.userModel.value =
                  UserModel.fromJson({'username': 'luoyi', 'password': 123456});
            },
            icon: const Icon(Icons.add),
          ),
        ],
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
            Obx(
              () => ElevatedButton(
                onPressed: () {
                  GlobalController.of.count.value++;
                  // GlobalController.of.count.value = '10';
                },
                child: Text('count: ${GlobalController.of.count.value}'),
              ),
            ),
            Obx(
              () => Text(GlobalController.of.userModel.value.toString()),
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
