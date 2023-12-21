import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:package/index.dart';

/// 全局主题控制器，执行[initMyFlutter]函数后初始化，你可以在任何地方访问它。
class ThemeController extends GetxController {
  /// 通过静态方法访问 ThemeController
  static ThemeController get of => Get.find();

  /// 主要颜色
  final primaryColor =
      useLocalObs(const Color.fromARGB(255, 0, 120, 212), 'primaryColor');

  /// 成功颜色
  final successColor =
      useLocalObs(const Color.fromARGB(255, 16, 185, 129), 'successColor');

  /// 警告颜色
  final warningColor =
      useLocalObs(const Color.fromARGB(255, 245, 158, 11), 'warningColor');

  /// 错误颜色
  final errorColor =
      useLocalObs(const Color.fromARGB(255, 239, 68, 68), 'errorColor');

  /// 普通颜色
  final infoColor =
      useLocalObs(const Color.fromARGB(255, 127, 137, 154), 'infoColor');

  /// 是否使用material3主题
  final useMaterial3 = useLocalObs(true, 'material3');

  /// 是否构建IOS风格App，如果为true，app将使用[CupertinoApp]构建
  final useIOS = useLocalObs(false, 'useIOS');

  /// 是否使用黑暗模式
  final useDark = useLocalObs(false, 'dark');

  /// 当主题是material2时，是否显示半透明状态栏
  final translucenceStatusBar = useLocalObs(true, 'translucenceStatusBar');

  @override
  void onInit() {
    super.onInit();
    ever(useMaterial3, (_) {
      _
          ? _hideTranslucenceStatusBar()
          : (translucenceStatusBar.value
              ? _showTranslucenceStatusBar()
              : _hideTranslucenceStatusBar());
    });
    ever(translucenceStatusBar, (_) {
      _ ? _showTranslucenceStatusBar() : _hideTranslucenceStatusBar();
    });
  }
}

void _showTranslucenceStatusBar() {
  CommonUtil.delayed(200, () {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
  });
}

void _hideTranslucenceStatusBar() {
  CommonUtil.delayed(200, () {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
  });
}
