import 'dart:ui';

import 'package:my_flutter/my_flutter.dart';

/// 初始化主题模型类，它会在你执行[initMyFlutter]函数时立即注入到[MyTheme]对象，随后你可以在任意地方使用[myTheme]实例调用全局主题
class ThemeModel {
  Color? primaryColor;
  Color? successColor;
  Color? warningColor;
  Color? errorColor;
  Color? infoColor;

  /// 自定义全局字体，当你遇到flutter字体渲染问题时将会使用它
  String? fontFamily;

  /// 设置全局普通文字字重，默认w500，flutter原始默认为w400
  FontWeight? defaultFontWeight;

  /// appbar高度
  double? appbarHeight;

  /// 是否全局启动波纹，默认true
  bool? enableRipple;

  /// 启用半透明状态栏，默认false
  bool? translucenceStatusBar;

  ThemeModel({
    this.primaryColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.infoColor,
    this.fontFamily,
    this.defaultFontWeight,
    this.appbarHeight,
    this.enableRipple,
    this.translucenceStatusBar,
  });
}
