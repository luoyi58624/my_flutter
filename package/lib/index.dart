library package;

import 'package:flutter/widgets.dart';
import 'index.dart';

export 'app.dart';
export 'controller/index.dart';
export 'common/index.dart';
export 'model/index.dart';
export 'page/index.dart';
export 'plugin/index.dart';
export 'util/index.dart';
export 'widget/index.dart';

/// 全局context，注意：请尽量不要使用全局context，除非你对BuildContext有一个清晰的认识
BuildContext? globalContext;

/// 本地存储，它基于get_storage，该库允许你根据tag创建多个实例，例如：
/// ```dart
///   httpLocalStorage = await LocalStorage.init('http');
/// ```
late LocalStorage localStorage;

/// 初始化
/// * theme 自定义主题
Future<void> initMyFlutter({
  ThemeModel? themeModel, // 初始化主题模型
}) async {
  localStorage = await LocalStorage.init();
  Get.put(ThemeController(themeModel));
}
