import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter/my_flutter.dart';

export 'root_page.dart';

class MyMaterialTheme {
  final ThemeData lightTheme;
  final ThemeData darkTheme;

  MyMaterialTheme(this.lightTheme, this.darkTheme);
}

/// 自定义material3的主题样式
final _primaryColor =
    ColorUtil.createMaterialColor(const Color.fromARGB(255, 0, 120, 212));

/// 自定义Material全局默认样式，material和cupertino不一样，它区分theme和darkTheme，同时配置上比cupertino复杂很多
late MyMaterialTheme myMaterialTheme;

class MyMaterialApp extends StatelessWidget {
  /// Material预设脚手架
  const MyMaterialApp({
    super.key,
    required this.home,
    this.title,
    this.useMaterial3 = false,
    this.primaryColor,
    this.theme,
    this.darkTheme,
    this.hiddenTranslucenceStatusBar = false,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
  });

  final Widget home;
  final String? title;
  final bool useMaterial3;

  /// 主题颜色
  final MaterialColor? primaryColor;

  /// 自定义亮色主题，若你只是不满足默认配置的部分属性，你可以使用 myMaterialTheme.lightTheme.copyWith 修改部分属性
  final ThemeData? theme;

  /// 自定义暗色主题，若你只是不满足默认配置的部分属性，你可以使用 myMaterialTheme.darkTheme.copyWith 修改部分属性
  final ThemeData? darkTheme;

  /// 是否隐藏半透明状态栏遮罩
  final bool hiddenTranslucenceStatusBar;

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  @override
  Widget build(BuildContext context) {
    if (hiddenTranslucenceStatusBar) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
    }
    if (onlyHorizontalMode) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    }
    if (onlyVerticalMode) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
    routePageType = RoutePageType.material;
    myMaterialTheme = MyMaterialTheme(
      useMaterial3
          ? _buildMaterial3ThemeData(
              ColorScheme.fromSeed(
                brightness: Brightness.light,
                seedColor: primaryColor ?? _primaryColor,
              ),
            )
          : _buildMaterial2ThemeData(
              Brightness.light,
              primaryColor ?? _primaryColor,
            ),
      useMaterial3
          ? _buildMaterial3ThemeData(
              ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: primaryColor ?? _primaryColor,
              ),
            )
          : _buildMaterial2ThemeData(
              Brightness.dark,
              primaryColor ?? _primaryColor,
            ),
    );
    return MaterialApp(
      title: title ?? 'Cupertino App',
      theme: theme ?? myMaterialTheme.lightTheme,
      darkTheme: darkTheme ?? myMaterialTheme.darkTheme,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
      locale: const Locale('zh', 'CN'),
      home: home,
      builder: builderMyApp(),
    );
  }
}

ThemeData _buildMaterial2ThemeData(
  Brightness brightness,
  MaterialColor primaryColor,
) {
  var themeData = ThemeData(
    useMaterial3: false,
    primarySwatch: primaryColor,
    brightness: brightness,
    textTheme: _textTheme,
    splashFactory: InkRipple.splashFactory,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: _textTheme.titleLarge?.fontWeight,
        color: ColorUtil.isDark(primaryColor) ? Colors.white : Colors.black,
      ),
    ),
  );
  return themeData;
}

ThemeData _buildMaterial3ThemeData(
  ColorScheme colorScheme,
) {
  var themeData = ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    textTheme: _textTheme,
    splashFactory: InkRipple.splashFactory,
    cardTheme: const CardTheme(
      surfaceTintColor: Colors.transparent,
    ),
  );
  return themeData;
}

const _textTheme = TextTheme(
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
);
