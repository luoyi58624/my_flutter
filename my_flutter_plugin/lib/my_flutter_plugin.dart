library my_flutter_plugin;

export 'package:flutter_localizations/flutter_localizations.dart';

// 仅导出getx状态管理，排除路由等其他功能
export 'package:get/get_core/get_core.dart';
export 'package:get/get_instance/get_instance.dart';
export 'package:get/get_state_manager/get_state_manager.dart';
export 'package:get/get_utils/get_utils.dart';
export 'package:get/get_rx/get_rx.dart';
