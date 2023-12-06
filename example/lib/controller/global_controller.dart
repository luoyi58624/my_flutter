import 'package:my_flutter/my_flutter.dart';

enum AppType {
  material(0),
  cupertino(1);

  final int value;

  const AppType(this.value);
}

class GlobalController extends GetxController {
  final appType = AppType.material.obs;
  final count = 0.obs;
}
