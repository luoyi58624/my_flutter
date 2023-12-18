library my_flutter;

import 'package:flutter/widgets.dart';
import 'package:get/instance_manager.dart';
import 'package:my_flutter/controller/theme_controller.dart';

import 'utils/local_storage.dart';
import 'utils/toast.dart';

export 'app.dart';
export 'controller/index.dart';
export 'common/index.dart';
export 'pages/index.dart';
export 'plugins/index.dart';
export 'utils/index.dart';
export 'widgets/index.dart';

/// 全局导航key，注意：如果你使用RouteUtil时不想传递context，那么你必须将此key挂载到MaterialApp或CupertinoApp下，
/// 但还有一点需要注意，此key保存的是我们App根navigator实例，如果你在嵌套路由中进行路由跳转，则不能使用全局导航key，你需要拿嵌套路由对应的navigator的context。
GlobalKey<NavigatorState> globalNavigatorKey = GlobalKey<NavigatorState>();

/// 全局context，注意：请不要在嵌套导航、颜色主题中使用它。
BuildContext? get globalContext => globalNavigatorKey.currentContext;

/// 本地存储，它基于get_storage，该库允许你根据tag创建多个实例，例如：
/// ```dart
///   await GetStorage.init('http');
///   httpLocalStorage = LocalStorage('http');
/// ```
late LocalStorage localStorage;

/// 初始化
/// * theme 自定义主题
Future<void> initMyFlutter() async {
  localStorage = await LocalStorage.init();
  Get.put(ThemeController());
}

/// MaterialApp、CupertinoApp的 builder 参数，初始化全局toast、解决modal_bottom_sheet在高版本安卓系统上动画丢失问题
TransitionBuilder builderMyApp() => (context, child) {
      return Overlay(
        initialEntries: [
          OverlayEntry(builder: (context) {
            toast.init(context);
            return MediaQuery(
              // 解决modal_bottom_sheet在高版本安卓系统上动画丢失
              data:
                  MediaQuery.of(context).copyWith(accessibleNavigation: false),
              child: child!,
            );
          }),
        ],
      );
    };
