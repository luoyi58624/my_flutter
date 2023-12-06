import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino.dart';
import 'package:my_flutter_app/controller/global_controller.dart';

import 'pages/root_page/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  Get.put(GlobalController());
  runApp(
    MyCupertinoApp(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const RootPage()),
        GoRoute(
            path: '/shop_search',
            builder: (context, state) => const RootPage()),
      ],
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
      ),
    ),
  );
}
