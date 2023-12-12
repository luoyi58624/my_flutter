import 'package:flutter/material.dart';
import 'package:material_app/controller/global_controller.dart';
import 'package:my_flutter/my_flutter.dart';

class TemplateRootPage extends StatefulWidget {
  const TemplateRootPage({super.key});

  @override
  State<TemplateRootPage> createState() => _TemplateRootPageState();
}

class _TemplateRootPageState extends State<TemplateRootPage> {
  @override
  Widget build(BuildContext context) {
    LoggerUtil.i('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('模版列表'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            GlobalController.of.homeBadge.value++;
          },
          child: Obx(
            () => Text('home badge: ${GlobalController.of.homeBadge.value}'),
          ),
        ),
      ),
    );
  }
}
