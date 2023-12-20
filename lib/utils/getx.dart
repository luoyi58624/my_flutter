import 'dart:convert';

import 'package:flutter/material.dart';

import '../my_flutter.dart';

class _LocalDataModel {
  /// 持久化数据类型字符串，如果类型发生变化将清除旧的本地数据
  late String type;
  dynamic data;

  _LocalDataModel(this.type, this.data);

  _LocalDataModel.fromJson(Map<String, dynamic> json) {
    type = json['type'] ?? '';
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final mapData = <String, dynamic>{};
    mapData['type'] = type;
    mapData['data'] = data;
    return mapData;
  }
}

typedef SerializeFun<T> = String Function(T newValue);
typedef DeserializeFun<T> = T Function(String newValue);

/// 创建一个响应式、可观察的变量(Observable State)，更新时会同步至本地，重新加载时会取本地数据作为初始值
/// * value - 初始值
/// * key - 本地缓存key
/// * serializeFun - 序列化函数，如果你传入的是对象，你必须将其转换为字符串才能缓存在本地
/// * deserializeFun - 反序列化函数，将本地存储的字符串转回目标对象
Rx<T> useLocalObs<T>(
  T value,
  String key, {
  SerializeFun<T>? serializeFun,
  DeserializeFun<T>? deserializeFun,
}) {
  String valueType = T.toString();
  bool isBaseType = CommonUtil.isBaseTypeString(valueType);
  // 序列化Color对象
  if (value is Color) {
    serializeFun ??= (value) => (value as Color).toHex();
    deserializeFun ??= (value) => ColorUtil.hexToColor((value)) as T;
  }
  assert(isBaseType || (serializeFun != null && deserializeFun != null),
      '请为响应式持久化变量[$key]提供序列化和反序列化函数');
  late Rx<T> $value;
  dynamic localData = localStorage.getItem(key);
  if (localData == null) {
    $value = value.obs;
  } else {
    var localDataModel = _LocalDataModel.fromJson(jsonDecode(localData));
    // 如果更改了响应式变量类型，则清除旧数据
    if (localDataModel.type != valueType) {
      localStorage.removeItem(key);
      $value = value.obs;
    } else {
      if (isBaseType) {
        $value = (localDataModel.data as T).obs;
      } else {
        $value = deserializeFun!(localDataModel.data).obs;
      }
    }
  }
  // 提示：当你卸载控制器后getx会自动释放它，无须手动销毁
  ever($value, (v) {
    localStorage.setItem(
        key,
        jsonEncode(_LocalDataModel(
                valueType, serializeFun == null ? v : serializeFun(v))
            .toJson()));
  });
  return $value;
}

/// 创建一个响应式Map变量，key强制为String，更新时会同步至本地，重新加载时会取本地数据作为初始值
/// * value - 初始值
/// * key - 本地缓存key
/// * serializeFun - 序列化函数，如果你传入的是对象，你必须将其转换为字符串才能缓存在本地
/// * deserializeFun - 反序列化函数，将本地存储的字符串转回目标对象
///
/// 示例：
/// ```dart
/// // value为int类型的Map
/// final localMap = useLocalMapObs<int>({}, 'localMap');
///
/// // value为Model实体对象类型的Map，必须包含序列化方法toJson、fromJson
/// final userModelMap = useLocalMapObs<UserModel>(
///   {},
///   'userModelMap',
///   serializeFun: (value) => jsonEncode(value.toJson()),
///   deserializeFun: (value) => UserModel.fromJson(jsonDecode(value)),
/// );
///
/// // 注意：操作响应式Map不要加.value
/// controller.localMap['key'] = 1;
/// controller.localMap.addAll({'key': 1});
///
/// controller.localMap.update('key',(value)=>value+1);
/// ```
RxMap<String, T> useLocalMapObs<T>(
  Map<String, T> value,
  String key, {
  SerializeFun<T>? serializeFun,
  DeserializeFun<T>? deserializeFun,
}) {
  String valueType = T.toString();
  bool isBaseType = CommonUtil.isBaseTypeString(valueType);
  assert(isBaseType || (serializeFun != null && deserializeFun != null),
      '请为响应式持久化变量[$key]提供序列化和反序列化函数');
  late RxMap<String, T> $value;
  dynamic localData = localStorage.getItem(key);
  if (localData == null) {
    $value = value.obs;
  } else {
    var localDataModel = _LocalDataModel.fromJson(jsonDecode(localData));
    // 如果更改了响应式变量类型，则清除旧数据
    if (localDataModel.type != valueType) {
      localStorage.removeItem(key);
      $value = value.obs;
    } else {
      Map mapData = localDataModel.data;
      // 如果是基本数据类型，则直接通过cast强转类型返回数据，否则你必须提供序列化和反序列化函数进行转换
      if (CommonUtil.isBaseTypeString(valueType)) {
        $value = mapData.cast<String, T>().obs;
      } else {
        $value = mapData
            .map((key, value) => MapEntry(key, deserializeFun!(value)))
            .cast<String, T>()
            .obs;
      }
    }
  }
  ever($value, (v) {
    localStorage.setItem(
        key,
        jsonEncode(_LocalDataModel(
                valueType,
                serializeFun == null
                    ? v
                    : v.map((key, value) => MapEntry(key, serializeFun(value))))
            .toJson()));
  });
  return $value;
}
