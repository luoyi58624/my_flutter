library my_flutter;

import 'package:flutter/widgets.dart';

import 'my_flutter.dart';

export 'app.dart';
export 'theme.dart';
export 'common/index.dart';
export 'model/index.dart';
export 'page/index.dart';
export 'plugin/index.dart';
export 'util/index.dart';
export 'widget/index.dart';

/// 全局根节点导航key
GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

/// 全局根节点的context，注意：嵌套导航不要使用它
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// 默认的本地存储实例，它基于get_storage，支持所有平台。默认情况下，执行[initMyFlutter]会初始化一个LocalStorage，同时，它还允许你根据tag创建多个实例，例如：
/// ```dart
/// var httpLocalStorage = await LocalStorage.init('http');
/// var sessionLocalStorage = await LocalStorage.init('session');
/// ```
late LocalStorage localStorage;

/// 主题对象
late MyTheme myTheme;

/// 初始化
/// * themeModel 自定义主题，你也可以直接通过ThemeController.of修改主题
Future<void> initMyFlutter({
  ThemeModel? themeModel,
}) async {
  localStorage = await LocalStorage.init();
  myTheme = MyTheme(themeModel);
}
