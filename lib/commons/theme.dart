import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/color.dart';

List<int> _lightLevel = [100, 200, 300, 400];
List<int> _darkLevel = [900, 800, 700, 600];

List<Color> _lightGrey =
    List.generate(4, (index) => Colors.grey[_lightLevel[index]]!);

List<Color> _darkGrey =
    List.generate(4, (index) => Colors.grey[_darkLevel[index]]!);

/// 全局主题实例，执行initMyFlutter函数时初始化
late MyTheme myTheme;

class MyTheme {
  /// 是否使用material3主题
  bool get useMaterial3 => false;

  /// appbar的高度
  double get appbarHeight => 56;

  /// 主要颜色
  MaterialColor get primaryColor =>
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 0, 120, 212));

  /// 成功提示颜色
  MaterialColor get successColor =>
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 16, 185, 129));

  /// 警告提示颜色
  MaterialColor get warningColor =>
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 245, 158, 11));

  /// 错误提示颜色
  MaterialColor get errorColor =>
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 239, 68, 68));

  /// 普通提示颜色
  MaterialColor get infoColor =>
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 127, 137, 154));

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
