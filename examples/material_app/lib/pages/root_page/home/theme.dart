import 'package:flutter/material.dart';
import 'package:material_app/controllers/global_controller.dart';
import 'package:my_flutter/my_flutter.dart';

class ThemePage extends GetView<GlobalController> {
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('开启Material3'),
              trailing: Obx(
                () => Switch(
                  // This bool value toggles the switch.
                  value: controller.useMaterial3.value,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    controller.useMaterial3.value = value;
                  },
                ),
              ),
            ),
            ListTile(
              title: const Text('黑暗模式'),
              trailing: Obx(
                () => Switch(
                  // This bool value toggles the switch.
                  value: controller.isDark.value,
                  onChanged: (bool value) {
                    // This is called when the user toggles the switch.
                    controller.isDark.value = value;
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
