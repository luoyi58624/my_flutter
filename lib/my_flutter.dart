library my_flutter;

import 'package:flustars/flustars.dart';

export 'package:flustars/flustars.dart';
export 'package:get/get.dart';
export 'package:go_router/go_router.dart';

export './modals/simple_modals.dart';

export './utils/color.dart';
export './utils/logger.dart';
export './utils/common.dart';
export './utils/toast.dart';
export './utils/no_ripper.dart';
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
