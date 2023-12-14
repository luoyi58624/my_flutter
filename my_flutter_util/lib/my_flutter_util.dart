library my_flutter_util;

export 'color.dart';
export 'common.dart';
export 'event_bus.dart';
export 'local_storage.dart';
export 'logger.dart';
export 'no_ripper.dart';
export 'router.dart';
export 'toast.dart';
export 'vibrate.dart';

/// 是否为release版
const bool isRelease = bool.fromEnvironment("dart.vm.product");
