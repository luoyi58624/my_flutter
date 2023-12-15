import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter_app/controller/global_controller.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  Get.put(GlobalController());
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => MyApp(
        router,
        theme: buildMaterialThemeData(
          brightness: GlobalController.of.useDark.value
              ? Brightness.dark
              : Brightness.light,
          useMaterial3: GlobalController.of.useMaterial3.value,
        ),
        darkTheme: buildMaterialThemeData(
          brightness: Brightness.dark,
          useMaterial3: GlobalController.of.useMaterial3.value,
        ),
      ),
    );
  }
}
