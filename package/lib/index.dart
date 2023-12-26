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

/// 全局根节点导航key，请你手动请在[GoRouter]实例中传入此key，否则一些用到全局context的工具类会报错，例如[LoadingUtil]，[RouterUtil]的无context导航也依赖于它，若不传递，那么你必须手动传递context。
/// ```dart
/// final router = GoRouter(
///   navigatorKey: globalNavigatorKey,
///   routes: [],
/// );
GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

/// 全局根节点的context，注意：如果你当前使用场景是嵌套导航，那么请不要使用它，嵌套导航的正确路由跳转必须传递当前widget的context。
///
/// 提示：嵌套导航实际上是创建多个[Navigator]实例来实现并行导航，而我们当前[globalNavigatorKey]所属的是[MaterialApp]创建的[Navigator]实例，
/// 如果你使用[globalNavigatorKey]进行嵌套路由导航，你会出现路由跳转异常，你必须使用当前context来进行导航，[RouterUtil]提供的context参数正是为此而存在。
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// 默认的本地存储实例，它基于get_storage，支持所有平台。默认情况下，执行[initMyFlutter]会初始化一个LocalStorage，同时，它还允许你根据tag创建多个实例，例如：
/// ```dart
/// var httpLocalStorage = await LocalStorage.init('http');
/// var sessionLocalStorage = await LocalStorage.init('session');
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
