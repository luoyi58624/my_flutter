import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ColorMode {
  auto,
  light,
  dark,
}

List<int> _lightLevel = [100, 200, 300, 400];
List<int> _darkLevel = [900, 800, 700, 600];

List<Color> _lightGrey =
    List.generate(4, (index) => Colors.grey[_lightLevel[index]]!);

List<Color> _darkGrey =
    List.generate(4, (index) => Colors.grey[_darkLevel[index]]!);

/// 项目中的基础颜色，你可以通过继承覆写它们实现自定义颜色
abstract class MyBaseColors {
  static MaterialColor primaryColor =
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 0, 120, 212));

  static MaterialColor successColor =
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 16, 185, 129));

  static MaterialColor warningColor =
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 245, 158, 11));

  static MaterialColor errorColor =
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 239, 68, 68));

  static MaterialColor infoColor =
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 127, 137, 154));

  static Color baseColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.white,
      Colors.black,
      context,
      mode: mode,
    );
  }

  /// 头部背景颜色
  static Color headerColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.white,
      Theme.of(context).colorScheme.surface,
      context,
      mode: mode,
    );
  }

  /// 底部导航背景颜色
  static Color bottomBarbackgroundColor(BuildContext context,
      {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.grey.shade50,
      Colors.grey.shade800,
      context,
      mode: mode,
    );
  }

  /// 背景颜色
  static Color backgroundColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      const Color(0xFFf1f1f1),
      const Color(0xFF222222),
      context,
      mode: mode,
    );
  }

  /// input输入框填充背景色
  static Color inputFileColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.grey.shade200,
      Colors.grey.shade700,
      context,
      mode: mode,
    );
  }

  /// input输入框提示颜色
  static Color inputHintColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.grey.shade500,
      Colors.grey.shade300,
      context,
      mode: mode,
    );
  }

  /// 文本颜色
  static Color textColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.grey.shade900,
      Colors.grey.shade50,
      context,
      mode: mode,
    );
  }

  /// 二级文本颜色
  static Color secondTextColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.grey.shade800,
      Colors.grey.shade100,
      context,
      mode: mode,
    );
  }

  /// 分割线颜色
  static Color separatorColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      const Color.fromARGB(73, 60, 60, 67),
      const Color.fromARGB(153, 84, 84, 88),
      context,
      mode: mode,
    );
  }

  /// 骨架屏颜色
  static Color skeletonColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.grey.shade300,
      Theme.of(context).colorScheme.surface,
      context,
      mode: mode,
    );
  }

  /// 骨架屏高亮颜色
  static Color skeletonHighlightColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.grey.shade100,
      Theme.of(context).colorScheme.surface.withAlpha(200),
      context,
      mode: mode,
    );
  }

  /// IOS ListTile颜色
  static Color cupertinoListTileColor(BuildContext context, {ColorMode? mode}) {
    return ColorUtil.dynamicColor(
      Colors.white,
      CupertinoColors.systemFill,
      context,
      mode: mode,
    );
  }

  static Color dynamicGrey(BuildContext context,
      {int level = 1, bool reversal = false}) {
    assert(level >= 1 && level <= 4, 'level颜色级别超出范围: 1-4');
    if (reversal) {
      return ColorUtil.dynamicColor(
        _darkGrey[level - 1],
        _lightGrey[level - 1],
        context,
      );
    } else {
      return ColorUtil.dynamicColor(
        _lightGrey[level - 1],
        _darkGrey[level - 1],
        context,
      );
    }
  }
}

/// 颜色工具类
class ColorUtil {
  ColorUtil._();

  /// 判断一个颜色是否是暗色
  static bool isDark(Color color) {
    return getColorHsp(color) <= 165;
  }

  /// 返回一个颜色的hsp (颜色的感知亮度)
  static int getColorHsp(Color color) {
    final int r = color.red, g = color.green, b = color.blue;
    double hsp = sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b));
    return hsp.ceilToDouble().toInt();
  }

  /// 根据明亮度获取一个新的颜色，lightness以1为基准，小于1则颜色变暗，大于1则颜色变亮
  static Color getLightnessColor(Color color, double lightness) {
    final originalColor = HSLColor.fromColor(color);
    final newLightness = originalColor.lightness * lightness;
    final newColor = originalColor.withLightness(newLightness.clamp(0.0, 1.0));
    return newColor.toColor();
  }

  /// 创建material颜色
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  /// 是否为黑暗模式，要想保持响应式必须以函数形式使用
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).colorScheme.brightness == Brightness.dark;
  }

  /// 返回一个动态颜色
  static Color dynamicColor(
    lightColor,
    darkColor,
    BuildContext context, {
    ColorMode? mode,
  }) {
    ColorMode colorMode = mode ?? ColorMode.auto;
    switch (colorMode) {
      case ColorMode.auto:
        return isDarkMode(context) ? darkColor : lightColor;
      case ColorMode.light:
        return lightColor;
      case ColorMode.dark:
        return darkColor;
    }
  }
}
