import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'my_flutter.dart';

const Color _primaryColor = Color.fromARGB(255, 0, 120, 212);
const Color _successColor = Color.fromARGB(255, 16, 185, 129);
const Color _warningColor = Color.fromARGB(255, 245, 158, 11);
const Color _errorColor = Color.fromARGB(255, 239, 68, 68);
const Color _infoColor = Color.fromARGB(255, 127, 137, 154);

List<int> _lightLevel = [100, 200, 300, 400];
List<int> _darkLevel = [900, 800, 700, 600];

List<Color> _lightGrey = List.generate(4, (index) => Colors.grey[_lightLevel[index]]!);

List<Color> _darkGrey = List.generate(4, (index) => Colors.grey[_darkLevel[index]]!);

class MyTheme {
  late Color primaryColor;
  late Color successColor;
  late Color warningColor;
  late Color errorColor;
  late Color infoColor;
  late double appbarHeight;

  MyTheme([ThemeModel? _]) {
    primaryColor = _?.primaryColor ?? _primaryColor;
    successColor = _?.successColor ?? _successColor;
    warningColor = _?.warningColor ?? _warningColor;
    errorColor = _?.errorColor ?? _errorColor;
    infoColor = _?.infoColor ?? _infoColor;
    appbarHeight = _?.appbarHeight ?? 56;
  }

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

  Color dynamicGrey(BuildContext context, {int level = 1, bool reversal = false}) {
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

  /// 构建material主题
  ThemeData buildThemeData({
    Brightness brightness = Brightness.light, // 强制指定亮色主题或黑色主题
  }) {
    var $theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: primaryColor,
      ),
    );
    return ThemeData(
      useMaterial3: true,
      // 解决web上material按钮外边距为0问题，与移动端的效果保持一致
      materialTapTargetSize: MaterialTapTargetSize.padded,
      visualDensity: VisualDensity.standard,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
      }),
      textTheme: _TextTheme,
      // 根据主题色创建material3的主题系统
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: primaryColor,
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
      expansionTileTheme: ExpansionTileThemeData(
        textColor: $theme.primaryColor,
        shape: Border.all(width: 0, style: BorderStyle.none),
        collapsedShape: Border.all(width: 0, style: BorderStyle.none),
      ),
    );
  }
}

const _TextTheme = TextTheme(
  displaySmall: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  displayMedium: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  displayLarge: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  titleSmall: TextStyle(
    fontWeight: FontWeight.w700,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w700,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.w700,
  ),
  bodySmall: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w500,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.w500,
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

/// material加粗后的文字主题
const _materialBoldTextTheme = TextTheme(
  displaySmall: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  ),
  displayMedium: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  ),
  displayLarge: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  titleSmall: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
  ),
  titleMedium: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 18,
  ),
  titleLarge: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  ),
  bodySmall: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  ),
  bodyMedium: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  ),
  bodyLarge: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  labelSmall: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13,
  ),
  labelMedium: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  ),
  labelLarge: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15,
  ),
);