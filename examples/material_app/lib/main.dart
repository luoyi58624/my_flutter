import 'package:flutter/material.dart';
import 'package:material_app/controllers/global_controller.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/material/index.dart';

import 'pages/root_page/root_page.dart';

void main() async {
  await initMyFlutter();
  Get.put(GlobalController());
  runApp(const _MyApp());
}

class _MyApp extends GetView<GlobalController> {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MyMaterialApp(
        useMaterial3: controller.useMaterial3.value,
        showTranslucenceStatusBar: true,
        home: const RootPage(),
      ),
    );
  }
}
