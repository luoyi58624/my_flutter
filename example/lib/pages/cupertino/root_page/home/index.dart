import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter_app/controller/global_controller.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  final GlobalController globalController = Get.find();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('首页'),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoButton.filled(
              onPressed: () {
                globalController.count.value++;
              },
              child: Obx(() => Text('count: ${globalController.count.value}')),
            ),
            const SizedBox(height: 8),
            CupertinoButton.filled(
              onPressed: () {
                globalController.appType.value = AppType.material.value;
                RestartAppWidget.restartApp(context);
              },
              child: const Text('切换布局'),
            ),
          ],
        ),
      ),
    );
  }
}
