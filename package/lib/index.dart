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

/// 全局导航key，请在[GoRouter]实例中传入此key。
/// ```dart
/// final router = GoRouter(
///   navigatorKey: globalNavigatorKey,
///   routes: [],
/// );
GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

/// 全局context，注意：请不要在嵌套导航、颜色主题中使用它。
///
/// 警告：嵌套导航实际上是创建多个[Navigator]实例来实现并行导航，而我们当前[globalNavigatorKey]所属的是[MaterialApp]创建的[Navigator]实例，
/// 如果你使用[globalNavigatorKey]进行嵌套路由导航，你会出现路由跳转异常，你必须使用当前context来进行导航，[RouterUtil]提供的context参数正是为此而存在。
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
