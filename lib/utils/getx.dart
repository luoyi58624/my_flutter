import 'package:get/get.dart';

import 'local_storage.dart';

/// 创建一个响应式变量，更新时会同步至本地，重新加载时会取本地数据作为初始值
Rx<T> useLocalObs<T>(T value, String key) {
  final _value = localStorage.getItem(key, value).obs;
  // 提示：当你卸载控制器后getx会自动释放它，无须手动销毁
  ever(_value, (v) {
    localStorage.setItem(key, v);
  });
  return _value;
}