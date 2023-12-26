import 'package:flutter/material.dart';
import 'package:package/index.dart';

import '../../../../common/data.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App主题设置'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          buildCell(),
          const SizedBox(height: 8),
          buildPrimaryTheme(),
        ]),
      ),
    );
  }

  Widget buildCell() {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('开启Material3'),
            trailing: Obx(
              () => Switch(
                value: ThemeController.of.useMaterial3.value,
                onChanged: (bool value) {
                  ThemeController.of.useMaterial3.value = value;
                },
              ),
            ),
          ),
          ListTile(
            title: const Text('黑暗模式'),
            trailing: Obx(
              () => Switch(
                value: ThemeController.of.useDark.value,
                onChanged: (bool value) {
                  ThemeController.of.useDark.value = value;
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPrimaryTheme() {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      child: ExpansionTile(
        leading: const Icon(Icons.color_lens),
        title: const Text('主题颜色'),
        initiallyExpanded: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: colorList.map((color) {
                return InkWell(
                  onTap: () {
                    ThemeController.of.primaryColor.value = color;
                  },
                  child: Obx(
                    () => Container(
                      width: 40,
                      height: 40,
                      color: color,
                      // ignore: unrelated_type_equality_checks
                      child: ThemeController.of.primaryColor.value == color
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
