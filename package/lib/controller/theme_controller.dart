import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package/index.dart';

const Color _primaryColor = Color.fromARGB(255, 0, 120, 212);
const Color _successColor = Color.fromARGB(255, 16, 185, 129);
const Color _warningColor = Color.fromARGB(255, 245, 158, 11);
const Color _errorColor = Color.fromARGB(255, 239, 68, 68);
const Color _infoColor = Color.fromARGB(255, 127, 137, 154);

/// 全局主题控制器，执行[initMyFlutter]函数后初始化，你可以在任何地方访问它。
///
/// 注意：你不可以拿[MaterialApp]嵌套其他的App([MaterialApp]、[CupertinoApp])，因为它们都属于顶级App，
/// 顶级App嵌套会出现路由跳转问题，所以在一个App内创建多个其他App的应用场景不存在，那么Getx创建的全局状态是不存在冲突的。
class ThemeController extends GetxController {
  /// 通过静态方法访问[ThemeController]
  static ThemeController get of => Get.find();

  ThemeController([ThemeModel? _]) {
    primaryColor = useLocalObs(_?.primaryColor ?? _primaryColor, 'primaryColor');
    successColor = useLocalObs(_?.successColor ?? _successColor, 'successColor');
    warningColor = useLocalObs(_?.warningColor ?? _warningColor, 'warningColor');
    errorColor = useLocalObs(_?.errorColor ?? _errorColor, 'errorColor');
    infoColor = useLocalObs(_?.infoColor ?? _infoColor, 'infoColor');
    useMaterial3 = useLocalObs(_?.useMaterial3 ?? true, 'useMaterial3');
    useDark = useLocalObs(_?.useDark ?? false, 'useDark');
  }

  /// 主要颜色
  late final Rx<Color> primaryColor;

  /// 成功颜色
  late final Rx<Color> successColor;

  /// 警告颜色
  late final Rx<Color> warningColor;

  /// 错误颜色
  late final Rx<Color> errorColor;

  /// 普通颜色
  late final Rx<Color> infoColor;

  /// 是否使用material3主题，flutter从3.16版本开始已默认启用material3
  late final Rx<bool> useMaterial3;

  /// 是否使用黑暗模式
  late final Rx<bool> useDark;

  /// 当主题是material2时，是否显示半透明状态栏
  final translucenceStatusBar = false.obs;

  /// 构建material主题
  ThemeData buildMaterialThemeData({
    Brightness brightness = Brightness.light, // 强制指定亮色主题或黑色主题
  }) {
    var pageTransitionsTheme = const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
    });
    if (useMaterial3.value) {
      hideTranslucenceStatusBar();
      var $theme = ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: primaryColor.value,
        ),
      );
      return ThemeData(
        useMaterial3: true,
        pageTransitionsTheme: pageTransitionsTheme,
        textTheme: _materialBoldTextTheme,
        // 根据主题色创建material3的主题系统
        colorScheme: ColorScheme.fromSeed(
          brightness: brightness,
          seedColor: primaryColor.value,
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
    } else {
      translucenceStatusBar.value ? showTranslucenceStatusBar() : hideTranslucenceStatusBar();
      return ThemeData(
        useMaterial3: false,
        pageTransitionsTheme: pageTransitionsTheme,
        textTheme: _materialBoldTextTheme,
        brightness: brightness,
        // 指定material2的主题颜色
        primarySwatch: ColorUtil.createMaterialColor(primaryColor.value),
        splashFactory: InkRipple.splashFactory,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorUtil.isDark(primaryColor.value) ? Colors.white : Colors.black,
          ),
          actionsIconTheme: IconThemeData(
            color: ColorUtil.isDark(primaryColor.value) ? Colors.white : Colors.black,
          ),
          foregroundColor: ColorUtil.isDark(primaryColor.value) ? Colors.white : Colors.black,
        ),
        expansionTileTheme: ExpansionTileThemeData(
          shape: Border.all(width: 0, style: BorderStyle.none),
          collapsedShape: Border.all(width: 0, style: BorderStyle.none),
        ),
      );
    }
  }

  /// 构建cupertino主题
  CupertinoThemeData buildCupertinoTheme({
    Brightness brightness = Brightness.light, // 强制指定亮色主题或黑色主题
  }) {
    hideTranslucenceStatusBar();
    var textTheme = const CupertinoThemeData().textTheme;
    return CupertinoThemeData(
      primaryColor: primaryColor.value,
      textTheme: CupertinoTextThemeData(
        textStyle: textTheme.textStyle.copyWith(fontWeight: FontWeight.w500),
        tabLabelTextStyle: textTheme.tabLabelTextStyle.copyWith(fontSize: 12),
        navActionTextStyle: textTheme.navActionTextStyle.copyWith(
          fontWeight: FontWeight.w500,
          color: primaryColor.value,
        ),
      ),
    );
  }

  /// 显示半透明状态栏
  void showTranslucenceStatusBar() {
    CommonUtil.delayed(200, () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
    });
  }

  /// 隐藏半透明状态栏
  void hideTranslucenceStatusBar() {
    CommonUtil.delayed(200, () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    });
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
