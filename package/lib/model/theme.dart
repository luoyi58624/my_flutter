import 'dart:ui';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme.freezed.dart';

@freezed
class ThemeModel with _$ThemeModel {
  /// 主题初始化模型
  const factory ThemeModel({
    Color? primaryColor,
    Color? successColor,
    Color? warningColor,
    Color? errorColor,
    Color? infoColor,
    bool? useMaterial3,
    bool? useDark,
    bool? textBold,
  }) = _ThemeModel;
}
