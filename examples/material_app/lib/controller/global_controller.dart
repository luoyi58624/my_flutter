import 'package:my_flutter/my_flutter.dart';

class GlobalController extends GetxController {
  /// 获取GlobalController实例，使用方式：GlobalController.of.xxxx
  static GlobalController get of => Get.find();

  final homeBadge = useLocalObs(0, 'homeBadge');
}
