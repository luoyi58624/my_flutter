library my_flutter;

import 'package:flutter/widgets.dart';
import 'package:my_flutter_common/my_flutter_common.dart';
import 'package:my_flutter_util/my_flutter_util.dart';

export 'package:my_flutter_common/my_flutter_common.dart';
export 'package:my_flutter_page/my_flutter_page.dart';
export 'package:my_flutter_plugin/my_flutter_plugin.dart';
export 'package:my_flutter_util/my_flutter_util.dart';
export 'package:my_flutter_widget/my_flutter_widget.dart';

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
