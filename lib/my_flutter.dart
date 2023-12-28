library my_flutter;

import 'package:flutter/widgets.dart';

import 'my_flutter.dart';

// flutter官方国际化库
export 'package:flutter_localizations/flutter_localizations.dart';

// flutter官方collection库，扩展集合函数
export 'package:collection/collection.dart';

// get状态管理，但排除路由功能，建议只把get当做一个管理全局状态的库，不要全盘接受get的全套解决方案，
// 毕竟此库只有作者一个维护，flutter的路由是一个很复杂的模块，我个人比较反感get将路由和状态耦合在一起的方案。
export 'package:get/get_core/get_core.dart';
export 'package:get/get_instance/get_instance.dart';
export 'package:get/get_state_manager/get_state_manager.dart';
export 'package:get/get_rx/get_rx.dart';
export 'package:get/get_utils/src/extensions/export.dart';
export 'package:get/get_utils/src/get_utils/get_utils.dart';
export 'package:get/get_utils/src/platform/platform.dart';
export 'package:get/get_utils/src/queue/get_queue.dart';

export 'app.dart';
export 'theme.dart';
export 'common/index.dart';
export 'model/index.dart';
export 'page/index.dart';
export 'util/index.dart';
export 'widget/index.dart';

/// 全局根节点导航key
GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

/// 全局根节点的context，注意：嵌套导航不要使用它
BuildContext get globalContext => globalNavigatorKey.currentContext!;

/// key-value本地存储对象
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
