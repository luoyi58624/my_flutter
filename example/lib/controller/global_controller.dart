import 'package:my_flutter/my_flutter.dart';

enum AppType {
  material(0),
  cupertino(1);

  final int value;

  const AppType(this.value);
}

class GlobalController extends GetxController {
  final appType = useLocalObs(AppType.cupertino.value, 'app_type');
  final count = 0.obs;
}
