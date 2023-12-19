import 'package:get_storage/get_storage.dart';

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

  /// 设置本地数据，注意：value如果是Object、Map等类型数据，你必须使用jsonEncode将其转换为String，
  /// 否则你取数据时将会出现类型转换错误，dart在类型方面上很蠢，数据类型转换要开发者全部手动进行解析。
  ///
  /// 例如，dynamic as int会报运行时错误，你必须先手动判断需要转换的数据类型，dynamic is int，然后再使用int.parse(dynamic)。
  void setItem(String key, dynamic value) {
    _storage.write(key, value);
  }

  /// 读取指定key数据
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
