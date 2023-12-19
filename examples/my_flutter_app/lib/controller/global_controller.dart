import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter_app/model/user_model.dart';

class GlobalController extends GetxController {
  static GlobalController get of => Get.find();

  final localMap = useLocalMapObs<UserModel>({}, 'localMap', clear: true);
}
