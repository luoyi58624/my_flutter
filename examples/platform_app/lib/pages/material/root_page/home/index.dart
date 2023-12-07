import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:platform_app/controller/global_controller.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  final GlobalController globalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            globalController.appType.value = AppType.cupertino.value;
            RestartAppWidget.restartApp(context);
          },
          child: const Text('切换布局'),
        ),
      ),
    );
  }
}
