import 'package:my_flutter/my_flutter.dart';

class RouterController extends GetxController {
  static RouterController get of => Get.find();
  final activePath = ''.obs;
}
