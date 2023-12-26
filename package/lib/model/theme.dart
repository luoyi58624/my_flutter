import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';

@freezed
class ThemeModel with _$ThemeModel {
  /// 主题初始化模型，通过模型进行初始化和直接通过controller修改唯一区别是：
  /// 避免覆盖本地持久化，如果你不需要动态修改主题的话可以直接通过controller进行修改。
  const factory ThemeModel({
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    bool? useDark,
  }) = _ThemeModel;
}
