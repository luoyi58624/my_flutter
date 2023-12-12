library my_flutter;

import 'package:flutter/widgets.dart';
import 'package:my_flutter/commons/theme.dart';
import 'package:my_flutter/utils/local_storage.dart';
import 'package:my_flutter/utils/toast.dart';

// 只导出get的核心以及工具函数，排除路由、http网络连接等其他依赖
export 'package:get/get_core/get_core.dart';
export 'package:get/get_instance/get_instance.dart';
export 'package:get/get_state_manager/get_state_manager.dart';
export 'package:get/get_utils/get_utils.dart';
export 'package:get/get_rx/get_rx.dart';
export 'package:dio/dio.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flustars/flustars.dart';
export 'package:go_router/go_router.dart';
export 'package:collection/collection.dart';
export 'package:flutter_animate/flutter_animate.dart';
export 'package:cupertino_icons/cupertino_icons.dart';
export 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
export 'package:faker/faker.dart';
export 'package:status_bar_control/status_bar_control.dart';
export 'package:page_transition/page_transition.dart';
export 'package:shimmer/shimmer.dart';
export 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
export 'package:permission_handler/permission_handler.dart';

export 'commons/modal.dart';
export 'commons/theme.dart';

export 'utils/color.dart';
export 'utils/common.dart';
export 'utils/event_bus.dart';
export 'utils/getx.dart';
export 'utils/loading.dart';
export 'utils/local_storage.dart';
export 'utils/logger.dart';
export 'utils/no_ripper.dart';
export 'utils/permission.dart';
export 'utils/router.dart';
export 'utils/toast.dart';
export 'utils/vibrate.dart';

export 'widgets/commons/badge.dart';
export 'widgets/commons/cascader.dart';
export 'widgets/commons/flex_wrap.dart';
export 'widgets/commons/flexible_title.dart';
export 'widgets/commons/hide_keybord.dart';
export 'widgets/commons/image.dart';
export 'widgets/commons/index_list.dart';
export 'widgets/commons/loading.dart';
export 'widgets/commons/restart_app.dart';
export 'widgets/commons/scroll_ripper.dart';
export 'widgets/commons/simple_widgets.dart';
export 'widgets/commons/skeleton.dart';
export 'widgets/commons/sliver.dart';
export 'widgets/commons/tag.dart';
export 'widgets/commons/tap_animate.dart';
export 'widgets/commons/text_highlight.dart';

export 'widgets/cupertino/list_group.dart';
export 'widgets/cupertino/list_tile.dart';

export 'pages/common/child_page.dart';

/// 是否为release版
const bool isRelease = bool.fromEnvironment("dart.vm.product");

/// 全局导航key，注意：如果你使用RouteUtil时不想传递context，那么你必须将此key挂载到MaterialApp或CupertinoApp下，
/// 但还有一点需要注意，此key保存的是我们App根navigator实例，如果你在嵌套路由中进行路由跳转，则不能使用全局导航key，你需要拿嵌套路由对应的navigator的context。
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> initMyFlutter({
  MyTheme? theme,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  myTheme = theme ?? MyTheme();
  localStorage = await LocalStorage.init();
}

/// MaterialApp、CupertinoApp的 builder 参数，初始化全局toast、解决modal_bottom_sheet在高版本安卓系统上动画丢失问题
TransitionBuilder builderMyApp() => (context, _child) {
      return Overlay(
        initialEntries: [
          OverlayEntry(builder: (context) {
            toast.init(context);
            return MediaQuery(
              // 解决modal_bottom_sheet在高版本安卓系统上动画丢失
              data:
                  MediaQuery.of(context).copyWith(accessibleNavigation: false),
              child: _child!,
            );
          }),
        ],
      );
    };
