import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

List<int> _lightLevel = [100, 200, 300, 400];
List<int> _darkLevel = [900, 800, 700, 600];

List<Color> _lightGrey =
    List.generate(4, (index) => Colors.grey[_lightLevel[index]]!);

List<Color> _darkGrey =
    List.generate(4, (index) => Colors.grey[_darkLevel[index]]!);

/// 全局主题实例，执行initMyFlutter函数时初始化
late MyTheme myTheme;

/// 通用的颜色主题
class MyTheme {
  /// 主要颜色
  Color get primaryColor => const Color.fromARGB(255, 0, 120, 212);

  /// 成功颜色
  Color get successColor => const Color.fromARGB(255, 16, 185, 129);

  /// 警告颜色
  Color get warningColor => const Color.fromARGB(255, 245, 158, 11);

  /// 错误颜色
  Color get errorColor => const Color.fromARGB(255, 239, 68, 68);

  /// 普通颜色
  Color get infoColor => const Color.fromARGB(255, 127, 137, 154);

  Color baseColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.white,
      Colors.black,
      context,
      mode: mode,
    );
  }

  /// 头部背景颜色
  Color headerColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.white,
      Theme.of(context).colorScheme.surface,
      context,
      mode: mode,
    );
  }

  /// 底部导航背景颜色
  Color bottomBarbackgroundColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.grey.shade50,
      Colors.grey.shade800,
      context,
      mode: mode,
    );
  }

  /// 背景颜色
  Color backgroundColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      const Color(0xFFf1f1f1),
      const Color(0xFF222222),
      context,
      mode: mode,
    );
  }

  /// input输入框填充背景色
  Color inputFileColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.grey.shade200,
      Colors.grey.shade700,
      context,
      mode: mode,
    );
  }

  /// input输入框提示颜色
  Color inputHintColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.grey.shade500,
      Colors.grey.shade300,
      context,
      mode: mode,
    );
  }

  /// 文本颜色
  Color textColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.grey.shade900,
      Colors.grey.shade50,
      context,
      mode: mode,
    );
  }

  /// 二级文本颜色
  Color secondTextColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.grey.shade800,
      Colors.grey.shade100,
      context,
      mode: mode,
    );
  }

  /// 分割线颜色
  Color separatorColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      const Color.fromARGB(73, 60, 60, 67),
      const Color.fromARGB(153, 84, 84, 88),
      context,
      mode: mode,
    );
  }

  /// 骨架屏颜色
  Color skeletonColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.grey.shade300,
      Theme.of(context).colorScheme.surface,
      context,
      mode: mode,
    );
  }

  /// 骨架屏高亮颜色
  Color skeletonHighlightColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.grey.shade100,
      Theme.of(context).colorScheme.surface.withAlpha(200),
      context,
      mode: mode,
    );
  }

  /// IOS ListTile颜色
  Color cupertinoListTileColor(BuildContext context, {ColorMode? mode}) {
    return dynamicColor(
      Colors.white,
      CupertinoColors.systemFill,
      context,
      mode: mode,
    );
  }

  Color dynamicGrey(BuildContext context,
      {int level = 1, bool reversal = false}) {
    assert(level >= 1 && level <= 4, 'level颜色级别超出范围: 1-4');
    if (reversal) {
      return dynamicColor(
        _darkGrey[level - 1],
        _lightGrey[level - 1],
        context,
      );
    } else {
      return dynamicColor(
        _lightGrey[level - 1],
        _darkGrey[level - 1],
        context,
      );
    }
  }

  /// 返回一个动态颜色
  Color dynamicColor(
    lightColor,
    darkColor,
    BuildContext context, {
    ColorMode? mode,
  }) {
    return ColorUtil.dynamicColor(lightColor, darkColor, context, mode: mode);
  }
}

/// 构建默认的Material3主题数据
ThemeData buildMaterial3ThemeData({
  Brightness brightness = Brightness.light,
}) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: myTheme.primaryColor,
    ),
    textTheme: const TextTheme(
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
}
