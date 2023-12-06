library my_flutter;

import 'package:flustars/flustars.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter/utils/toast.dart';

export 'package:flustars/flustars.dart';
export 'package:get/get.dart';
export 'package:go_router/go_router.dart';
export 'package:cupertino_icons/cupertino_icons.dart';

export './modals/simple_modals.dart';

export './utils/color.dart';
export './utils/common.dart';
export './utils/logger.dart';
export './utils/no_ripper.dart';
export './utils/permission.dart';
export './utils/router.dart';
export './utils/toast.dart';
export './utils/vibrate.dart';

export './widgets/badge.dart';
export './widgets/cascader.dart';
export './widgets/flex_wrap.dart';
export './widgets/flexible_title.dart';
export './widgets/hide_keybord.dart';
export './widgets/index_list.dart';
export './widgets/loading.dart';
export './widgets/scroll_ripper.dart';
export './widgets/simple_widgets.dart';
export './widgets/tag.dart';
export './widgets/tap_animate.dart';
export './widgets/text_highlight.dart';

Future<void> initMyFlutter() async {
  await SpUtil.getInstance();
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
