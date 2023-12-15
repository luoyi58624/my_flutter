import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter_app/controller/global_controller.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App主题设置'),
      ),
      body: buildCell(),
    );
  }

  Widget buildCell() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('开启Material3'),
              trailing: Obx(
                () => Switch(
                  value: GlobalController.of.useMaterial3.value,
                  onChanged: (bool value) {
                    GlobalController.of.useMaterial3.value = value;
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text('黑暗模式'),
              trailing: Obx(
                () => Switch(
                  value: GlobalController.of.useDark.value,
                  onChanged: (bool value) {
                    GlobalController.of.useDark.value = value;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
