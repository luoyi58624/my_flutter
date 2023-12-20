import 'package:flutter/material.dart';
import 'package:package/index.dart';
import 'package:my_flutter_app/controller/global_controller.dart';
import 'package:provider/provider.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  Get.put(GlobalController());
  runApp(const RestartAppWidget(child: _MyApp()));
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Provider(
        create: (context) => LabelModel('root', 'hello'),
        child: MyApp(
          router,
          darkTheme: ThemeController.of
              .buildMaterialThemeData(brightness: Brightness.dark),
        ),
      ),
    );
  }
}
