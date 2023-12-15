library my_flutter;

import 'package:flutter/widgets.dart';

import 'common/index.dart';
import 'utils/toast.dart';

export 'common/index.dart';
export 'pages/index.dart';
export 'plugins/index.dart';
export 'utils/index.dart';
export 'widgets/index.dart';

/// 初始化
/// * theme 自定义主题
Future<void> initMyFlutter({
  MyTheme? theme,
}) async {
  myTheme = theme ?? MyTheme();
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
