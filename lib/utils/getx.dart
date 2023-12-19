import 'dart:convert';

import 'package:flutter/material.dart';

import '../my_flutter.dart';

typedef SerializeFun<T> = String Function(T newValue);
typedef DeserializeFun<T> = T Function(String newValue);

/// 创建一个响应式变量，更新时会同步至本地，重新加载时会取本地数据作为初始值
/// * value - 初始值
/// * key - 本地缓存key
/// * serializeFun - 序列化函数，如果你传入的是对象，例如[Color]，你必须将其转换为字符串才能缓存在本地。
/// * deserializeFun - 反序列化函数，将本地存储的字符串转回目标对象
Rx<T> useLocalObs<T>(
  T value,
  String key, {
  SerializeFun<T>? serializeFun,
  DeserializeFun<T>? deserializeFun,
}) {
  late Rx<T> $value;
  // 设置Color默认的序列化函数，如果你需要缓存其他对象类型，请参照下面的写法即可
  if (value is Color) {
    serializeFun ??= (value) => (value as Color).toHex();
    deserializeFun ??= (value) => ColorUtil.hexToColor((value)) as T;
  }
  dynamic localValue = localStorage.getItem(key);
  if (localValue == null) {
    $value = value.obs;
  } else {
    if (deserializeFun == null) {
      assert(CommonUtil.isBaseType(localValue), '请提供反序列化函数');
      $value = (localValue as T).obs;
    } else {
      $value = deserializeFun(localValue).obs;
    }
  }
  // 提示：当你卸载控制器后getx会自动释放它，无须手动销毁
  ever($value, (v) {
    localStorage.setItem(key, serializeFun == null ? v : serializeFun(v));
  });
  return $value;
}

/// 创建一个响应式Map变量，key强制为String，更新时会同步至本地，重新加载时会取本地数据作为初始值。
/// * value - 初始值
/// * key - 本地缓存key
/// * clear - 是否清除本地值
/// * serializeFun - 序列化函数，如果你传入的是对象，例如[Color]、[List]、[Map]，你必须将其转换为字符串才能缓存在本地。
/// * deserializeFun - 反序列化函数，将本地存储的字符串转回目标对象
///
/// 示例：
/// ```dart
/// final localMap = useLocalMapObs<int>({}, 'localMap');
///
/// // 注意：操作响应式Map不要加.value
/// controller.localMap['key'] = 1;
/// controller.localMap.addAll({'key': 1});
///
/// controller.localMap.update('key',(value)=>value+1);
/// ```
RxMap<String, V> useLocalMapObs<V>(
  Map<String, V> value,
  String key, {
  bool clear = false,
}) {
  if (clear) localStorage.removeItem(key);
  late RxMap<String, V> $value;
  dynamic localValue = localStorage.getItem(key);
  if (localValue == null) {
    $value = value.obs;
  } else {
    var mapData = (jsonDecode(localValue) as Map);
    mapData = mapData.map((key, value) {
      value = CommonUtil.dynamicToBaseType(value, V.toString());
      return MapEntry(key, value);
    });
    $value = mapData.cast<String, V>().obs;
  }
  ever($value, (v) {
    localStorage.setItem(key, jsonEncode(v));
  });
  return $value;
}
