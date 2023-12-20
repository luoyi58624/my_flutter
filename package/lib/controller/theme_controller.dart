import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../index.dart';

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

  /// 构建Material主题数据
  ThemeData buildMaterialThemeData({
    Brightness? brightness, // 强制指定亮色主题或黑色主题
  }) {
    brightness = brightness ??
        (ThemeController.of.useDark.value ? Brightness.dark : Brightness.light);
    if (useMaterial3.value) {
      return ThemeData(
        useMaterial3: true,
        textTheme: _textTheme,
        // 根据主题色创建material3的主题系统
        colorScheme: ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: primaryColor.value,
        ),
        splashFactory: InkRipple.splashFactory,
        cardTheme: const CardTheme(
          surfaceTintColor: Colors.transparent,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      );
    } else {
      return ThemeData(
        useMaterial3: false,
        textTheme: _textTheme,
        brightness: brightness,
        // 指定material2的主题颜色
        primarySwatch: ColorUtil.createMaterialColor(primaryColor.value),
        splashFactory: InkRipple.splashFactory,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorUtil.isDark(primaryColor.value)
                ? Colors.white
                : Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: ColorUtil.isDark(primaryColor.value)
                ? Colors.white
                : Colors.black,
          ),
          foregroundColor: ColorUtil.isDark(primaryColor.value)
              ? Colors.white
              : Colors.black,
        ),
      );
    }
  }

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

const _textTheme = TextTheme(
  displaySmall: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  displayMedium: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  displayLarge: TextStyle(
    fontWeight: FontWeight.w600,
  ),
  titleSmall: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.w600,
  ),
  bodySmall: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.w600,
  ),
  labelSmall: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  labelMedium: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  labelLarge: TextStyle(
    fontWeight: FontWeight.w500,
  ),
);
