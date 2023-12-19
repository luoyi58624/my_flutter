import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

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
              var length = GlobalController.of.userLocalMap.length + 1;
              // GlobalController.of.userLocalMap.value['列表项-$length'] =
              //     length.toString();
              GlobalController.of.userLocalMap.addAll({
                '列表项-$length': length.toString(),
              });
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
            GetBuilder<GlobalController>(
              builder: (_) => Text(_.userMap.toString()),
            ),
            GetBuilder<GlobalController>(builder: (_) {
              return ElevatedButton(
                onPressed: () {
                  GlobalController.of.increment();
                },
                child: Text(_.count.toString()),
              );
            }),
            Obx(() {
              return ElevatedButton(
                onPressed: () {
                  GlobalController.of.countObs.value++;
                },
                child: Text(GlobalController.of.countObs.value.toString()),
              );
            }),
            Obx(
              () => Text(GlobalController.of.userLocalMap.value.toString()),
            ),
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
