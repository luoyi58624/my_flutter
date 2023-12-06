library my_flutter;

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_flutter/utils/local_storage.dart';
import 'package:my_flutter/utils/toast.dart';

export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:flustars/flustars.dart';
export 'package:get/get.dart';
export 'package:go_router/go_router.dart';
export 'package:collection/collection.dart';
export 'package:flutter_animate/flutter_animate.dart';
export 'package:cupertino_icons/cupertino_icons.dart';

export 'modals/simple_modals.dart';

export 'utils/color.dart';
export 'utils/common.dart';
export 'utils/getx.dart';
export 'utils/local_storage.dart';
export 'utils/logger.dart';
export 'utils/no_ripper.dart';
export 'utils/permission.dart';
export 'utils/router.dart';
export 'utils/toast.dart';
export 'utils/vibrate.dart';

export 'widgets/badge.dart';
export 'widgets/cascader.dart';
export 'widgets/flex_wrap.dart';
export 'widgets/flexible_title.dart';
export 'widgets/hide_keybord.dart';
export 'widgets/image.dart';
export 'widgets/index_list.dart';
export 'widgets/loading.dart';
export 'widgets/restart_app.dart';
export 'widgets/scroll_ripper.dart';
export 'widgets/simple_widgets.dart';
export 'widgets/tag.dart';
export 'widgets/tap_animate.dart';
export 'widgets/text_highlight.dart';
export 'widgets/webview.dart';

export 'pages/child_page.dart';
export 'pages/cupertino_root_page.dart';

Future<void> initMyFlutter() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  localStorage = LocalStorage();
}

/// MaterialApp或CupertinoApp顶级组件的builder构造Widget，用于一些初始化操作，例如：初始化全局Toast、解决modal_bottom_sheet动画问题
class MyRootWidget extends StatelessWidget {
  const MyRootWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        OverlayEntry(builder: (context) {
          toast.init(context);
          return MediaQuery(
            // 解决modal_bottom_sheet在高版本安卓系统上动画丢失
            data: MediaQuery.of(context).copyWith(accessibleNavigation: false),
            child: child,
          );
        }),
      ],
    );
  }
}
