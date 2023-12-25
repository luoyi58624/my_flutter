library package;

import 'dart:io';

import 'package:flutter/foundation.dart';
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

/// 全局导航key，使用[MyApp]时将自动创建
GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

/// 全局context，注意：请不要在嵌套导航、颜色主题中使用它。
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// 本地存储，它基于get_storage，该库允许你根据tag创建多个实例，例如：
/// ```dart
///   httpLocalStorage = await LocalStorage.init('http');
/// ```
late LocalStorage localStorage;

/// 初始化
/// * themeModel 自定义主题，你也可以直接通过ThemeController.of修改主题
Future<void> initMyFlutter({
  ThemeModel? themeModel,
}) async {
  // 取消验证ssl证书
  if (!kIsWeb) HttpOverrides.global = GlobalHttpOverrides();
  localStorage = await LocalStorage.init();
  Get.put(ThemeController(themeModel));
}
