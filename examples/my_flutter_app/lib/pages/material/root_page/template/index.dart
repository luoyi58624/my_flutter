import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter_app/controller/global_controller.dart';

class TemplateRootPage extends StatefulWidget {
  const TemplateRootPage({super.key});

  @override
  State<TemplateRootPage> createState() => _TemplateRootPageState();
}

class _TemplateRootPageState extends State<TemplateRootPage> {
  @override
  Widget build(BuildContext context) {
    // LoggerUtil.i('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('模版列表'),
        actions: [
          IconButton(
            onPressed: () {
              GlobalController.of.addUserMap();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GetBuilder<GlobalController>(
        builder: (_) => Text(_.userMap.toString()),
      ),
    );
  }
}
