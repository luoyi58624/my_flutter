import 'package:get_storage/get_storage.dart';

/// 本地存储，它基于get_storage，该库允许你根据tag创建多个实例，例如：
/// ```dart
///   await GetStorage.init('http');
///   httpLocalStorage = LocalStorage('http');
/// ```
late LocalStorage localStorage;

class LocalStorage {
  static late GetStorage _storage;

  LocalStorage._();

  /// 初始化容器
  static Future<LocalStorage> init([String? tag]) async {
    if (tag != null) {
      await GetStorage.init(tag);
      _storage = GetStorage(tag);
    } else {
      await GetStorage.init();
      _storage = GetStorage();
    }
    return LocalStorage._();
  }

  /// 设置本地数据
  void setItem(String key, dynamic value) {
    _storage.write(key, value);
  }

  /// 读取指定key数据
  T getItem<T>(String key, T defaultValue) {
    return _storage.read<T>(key) ?? defaultValue;
  }

  /// 删除指定key数据
  void removeItem(String key) {
    _storage.remove(key);
  }

  /// 删除所有本地数据
  void clear() {
    _storage.erase();
  }
}
