import 'package:hive_flutter/hive_flutter.dart';

/// 简单key-value键值存储库，基于[Hive]，支持所有平台
class LocalStorage<D> {
  late Box<D> _storage;

  LocalStorage._();

  /// 初始化容器，由于构造函数不能是异步，所以只能提供静态方法创建，你可以根据tag创建多个容器，例如：
  /// ```dart
  /// var localStorage = await LocalStorage.init(); // 当执行initMyFlutter时默认创建
  /// var httpLocalStorage = await LocalStorage.init('http');
  /// var sessionLocalStorage = await LocalStorage.init('session');
  /// ```
  static Future<LocalStorage<D>> init<D>([String? tag]) async {
    return LocalStorage._().._storage = await Hive.openBox(tag ?? 'default');
  }

  /// 设置本地数据，提示：[Hive]支持存储对象，当你需要
  void setItem(String key, D value) {
    _storage.put(key, value);
  }

  /// 读取指定key数据
  D? getItem(String key, [D? defaultValue]) {
    return _storage.get(key, defaultValue: defaultValue);
  }

  /// 删除指定key数据
  void removeItem(String key) {
    _storage.delete(key);
  }

  /// 清除容器所有数据
  void clear() {
    _storage.clear();
  }
}
