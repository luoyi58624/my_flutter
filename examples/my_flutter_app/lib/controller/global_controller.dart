import 'package:my_flutter/my_flutter.dart';

class GlobalController extends GetxController {
  static GlobalController get of => Get.find();

  final useMaterial3 = useLocalObs(true, 'material3');
  final useDark = useLocalObs(false, 'dark');
}
