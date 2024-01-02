import 'package:get_storage/get_storage.dart';

/// 简单key-value键值存储库，基于get_storage，支持所有平台
class LocalStorage {
  static late GetStorage _storage;

  LocalStorage._();

  /// 初始化容器，你可以根据tag创建多个容器，例如：
  /// ```dart
  /// var localStorage = await LocalStorage.init(); // 当执行initMyFlutter时默认创建
  /// var httpLocalStorage = await LocalStorage.init('http');
  /// var sessionLocalStorage = await LocalStorage.init('session');
  /// ```
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

  /// 设置本地数据，注意：value如果是List、Map、Object等类型数据，你必须使用jsonEncode将其转换为String。
  ///
  /// 还有，在持久化模型对象时，由于flutter禁用了dart反射(反射会影响flutter treeshaking)，所以flutter在类型序列化、反序列化方面上很不智能，数据类型转换要开发者手动进行解析。
  void setItem(String key, dynamic value) {
    _storage.write(key, value);
  }

  /// 读取指定key数据，泛型T只能用于表示基本类型(String、int、bool...)，你不要将其用于对象，对象保存本地所存储的是字符串，将字符串解析为对象需要开发者手动处理。
  ///
  /// 注意：即使是处理基本类型，你也要确保与之前存储时的类型一致，哪怕是你之前存储的是String，你却指定int，那么flutter也会直接报类型转换错误，
  /// 因为dart不会尝试做任何的类型转换，哪怕是int转String这种简单的类型转换，也需要开发者手动调用toString方法。
  T? getItem<T>(String key, [T? defaultValue]) {
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
