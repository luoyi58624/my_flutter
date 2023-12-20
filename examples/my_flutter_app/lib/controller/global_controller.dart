import 'dart:convert';

import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter_app/model/user_model.dart';

class GlobalController extends GetxController {
  static GlobalController get of => Get.find();

  final count = useLocalObs(0, 'count');
  final userModel = UserModel().obs;
}
