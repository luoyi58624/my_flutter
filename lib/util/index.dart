export 'color.dart';
export 'common.dart';
export 'local_storage.dart';
export 'logger.dart';
export 'modal.dart';
export 'no_ripper.dart';
export 'platform.dart';
export 'router.dart';
export 'loading.dart';
export 'toast.dart';
export 'use_local_obs.dart';

/// 是否为release版
const bool isRelease = bool.fromEnvironment("dart.vm.product");

/// 获取当前时间的毫秒
int get currentMilliseconds => DateTime.now().millisecondsSinceEpoch;
