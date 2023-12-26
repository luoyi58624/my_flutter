import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../index.dart';

part 'theme.freezed.dart';

@freezed
class ThemeModel with _$ThemeModel {
  /// 主题初始化模型，通过模型进行初始化和直接通过controller修改唯一区别是：
  /// 避免覆盖本地持久化，如果你不需要动态修改主题的话可以直接通过controller进行修改。
  const factory ThemeModel({
    // 指定app类型，你依然可以使用MaterialApp进行构建应用，但你可能更喜欢Cupertino风格的路由过渡、滚动行为，
    // 你只需将传递AppType.cupertino即可实现在MaterialApp下全局应用cupertino的平台风格。
    AppType? appType,
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    bool? useMaterial3,
    bool? useDark,
    bool? textBold,
    String? bottomNavigationType,
  }) = _ThemeModel;
}
