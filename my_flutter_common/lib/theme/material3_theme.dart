import 'package:flutter/material.dart';
import 'package:my_flutter_util/my_flutter_util.dart';

/// material3主题
class MyMaterial3Theme {
  /// material3主要颜色
  MaterialColor get primaryColor =>
      ColorUtil.createMaterialColor(const Color.fromARGB(255, 0, 120, 212));
}

/// 构建Material3主题数据
ThemeData buildMaterial3ThemeData(ColorScheme colorScheme) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
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
