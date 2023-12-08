library my_flutter;

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
export 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
export 'package:faker/faker.dart';

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
export 'widgets/commons/sliver.dart';
export 'widgets/commons/tag.dart';
export 'widgets/commons/tap_animate.dart';
export 'widgets/commons/text_highlight.dart';
export 'widgets/commons/webview.dart';

export 'widgets/cupertino/list_group.dart';
export 'widgets/cupertino/list_tile.dart';

export 'pages/common/child_page.dart';

Future<void> initMyFlutter() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  localStorage = LocalStorage();
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
