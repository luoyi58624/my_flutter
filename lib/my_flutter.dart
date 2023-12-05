library my_flutter;

import 'package:flustars/flustars.dart';

export 'package:flustars/flustars.dart';
export 'package:get/get.dart';
export 'package:go_router/go_router.dart';

export './utils/logger.dart';
export './utils/common.dart';
export './utils/toast.dart';

Future<void> initMyFlutter() async {
  await SpUtil.getInstance();
}
