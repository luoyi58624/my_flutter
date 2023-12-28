// flutter官方国际化库
export 'package:flutter_localizations/flutter_localizations.dart';

// flutter官方collection库，扩展集合函数
export 'package:collection/collection.dart';

// get状态管理，但排除路由功能，建议只把get当做一个管理全局状态的库，不要全盘接受get的全套解决方案，
// 毕竟此库只有作者一个维护，flutter的路由是一个很复杂的模块，我个人比较反感get将路由和状态耦合在一起的方案。
export 'package:get/get_core/get_core.dart';
export 'package:get/get_instance/get_instance.dart';
export 'package:get/get_state_manager/get_state_manager.dart';
export 'package:get/get_rx/get_rx.dart';
export 'package:get/get_utils/src/extensions/export.dart';
export 'package:get/get_utils/src/get_utils/get_utils.dart';
export 'package:get/get_utils/src/platform/platform.dart';
export 'package:get/get_utils/src/queue/get_queue.dart';

// 底部弹窗库
export 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// ios下的图标
export 'package:cupertino_icons/cupertino_icons.dart';

// 常用工具类
export 'package:flustars/flustars.dart';

// 多平台查找文件系统上的常用位置
export 'package:path_provider/path_provider.dart';

// 加密解密工具包
export 'package:crypto/crypto.dart';

// 适应平台风格的组件集合
export 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

// 生成假数据
export 'package:faker/faker.dart';

// 加载动画组件集合
export 'package:flutter_spinkit/flutter_spinkit.dart';

// 给容器添加闪光动画组件
export 'package:shimmer/shimmer.dart';

// 扩展官方tabs，优化手感
export 'package:extended_tabs/extended_tabs.dart';

// 打开文件
export 'package:open_file_plus/open_file_plus.dart';

export 'package:flutter_html/flutter_html.dart';
