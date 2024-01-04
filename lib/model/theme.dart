import 'dart:ui';

class ThemeModel {
  Color? primaryColor;
  Color? successColor;
  Color? warningColor;
  Color? errorColor;
  Color? infoColor;

  /// 自定义全局字体，当你遇到flutter字体渲染问题时将会使用它
  String? fontFamily;

  /// appbar高度
  double? appbarHeight;

  /// 启用半透明状态栏，默认false
  bool? translucenceStatusBar;

  /// 主题初始化模型，通过模型进行初始化和直接通过controller修改唯一区别是：
  /// 避免覆盖本地持久化，如果你不需要动态修改主题的话可以直接通过controller进行修改。
  ThemeModel({
    this.primaryColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.infoColor,
    this.fontFamily,
    this.appbarHeight,
    this.translucenceStatusBar,
  });
}
