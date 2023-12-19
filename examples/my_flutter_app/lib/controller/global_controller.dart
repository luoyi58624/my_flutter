import 'package:my_flutter/my_flutter.dart';

class GlobalController extends GetxController {
  static GlobalController get of => Get.find();

  final countObs = 0.obs;
  int count = 0;

  final userLocalMap = useLocalMapObs<String, String>({}, 'userMap');
  // final userLocalMap = RxMap<String, String>({});
  // final userLocalMap = {}.obs;
  final userMap = {};

  void increment() {
    count++;
    update(); // 当调用增量时，使用update()来更新用户界面上的计数器变量。
  }

  void addUserMap() {
    // userLocalMap.value.addAll(other)
    var length = userMap.length + 1;
    userMap['列表项-$length'] = length;
    update(); // 当调用增量时，使用update()来更新用户界面上的计数器变量。
  }
}
