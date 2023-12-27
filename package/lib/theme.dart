import 'package:flutter/material.dart';

import 'model/theme.dart';

const Color _primaryColor = Color.fromARGB(255, 0, 120, 212);
const Color _successColor = Color.fromARGB(255, 16, 185, 129);
const Color _warningColor = Color.fromARGB(255, 245, 158, 11);
const Color _errorColor = Color.fromARGB(255, 239, 68, 68);
const Color _infoColor = Color.fromARGB(255, 127, 137, 154);

class MyTheme {
  late Color primaryColor;
  late Color successColor;
  late Color warningColor;
  late Color errorColor;
  late Color infoColor;

  MyTheme([ThemeModel? _]) {
    primaryColor = _?.primaryColor ?? _primaryColor;
    successColor = _?.successColor ?? _successColor;
    warningColor = _?.warningColor ?? _warningColor;
    errorColor = _?.errorColor ?? _errorColor;
    infoColor = _?.infoColor ?? _infoColor;
  }

  /// 构建material主题
  ThemeData buildThemeData({
    Brightness brightness = Brightness.light, // 强制指定亮色主题或黑色主题
  }) {
    var pageTransitionsTheme = const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    });
    var $theme = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        brightness: brightness,
        seedColor: primaryColor,
      ),
    );
    return ThemeData(
      useMaterial3: true,
      pageTransitionsTheme: pageTransitionsTheme,
      textTheme: _materialBoldTextTheme,
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
