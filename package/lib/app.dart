import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package/index.dart';

/// 默认的主题颜色
Color _primaryColor = const Color.fromARGB(255, 0, 120, 212);
Color _successColor = const Color.fromARGB(255, 16, 185, 129);
Color _warningColor = const Color.fromARGB(255, 245, 158, 11);
Color _errorColor = const Color.fromARGB(255, 239, 68, 68);
Color _infoColor = const Color.fromARGB(255, 127, 137, 154);

/// 默认的国际化配置
const List<LocalizationsDelegate<dynamic>> _localizationsDelegates = [
  GlobalWidgetsLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];

const _supportedLocales = [
  Locale('zh', 'CH'),
  Locale('en', 'US'),
];

/// material加粗后的文字主题
const _materialBoldTextTheme = TextTheme(
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

/// 底部导航栏类型
enum BottomNavigationType {
  material2,
  material3,
  cupertino,
}

/// app风格类型
enum AppType {
  material2,
  material3,
  cupertino,
}

/// MyApp全局主题
class MyTheme {
  MyTheme._();

  static MyThemeData? of(BuildContext context) {
    _MyThemeInheritedWidget? themeInheritedWidget =
        context.dependOnInheritedWidgetOfExactType<_MyThemeInheritedWidget>();
    return themeInheritedWidget?.themeData;
  }

  /// 构建material2主题
  static ThemeData buildMaterial2ThemeData({
    required Color primaryColor, // 主要颜色
    Brightness? brightness, // 强制指定亮色主题或黑色主题
    bool boldText = true, // 是否要全局加粗文字
  }) {
    return ThemeData(
      useMaterial3: false,
      textTheme: boldText ? _materialBoldTextTheme : null,
      brightness: brightness,
      // 指定material2的主题颜色
      primarySwatch: ColorUtil.createMaterialColor(primaryColor),
      splashFactory: InkRipple.splashFactory,
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: ColorUtil.isDark(primaryColor) ? Colors.white : Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: ColorUtil.isDark(primaryColor) ? Colors.white : Colors.black,
        ),
        foregroundColor:
            ColorUtil.isDark(primaryColor) ? Colors.white : Colors.black,
      ),
    );
  }

  /// 构建material3主题
  static ThemeData buildMaterial3ThemeData({
    required Color primaryColor, // 主要颜色
    Brightness brightness = Brightness.light, // 强制指定亮色主题或黑色主题
    bool boldText = true, // 是否要全局加粗文字
  }) {
    return ThemeData(
      useMaterial3: true,
      textTheme: boldText ? _materialBoldTextTheme : null,
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
    );
  }

  /// 构建cupertino主题
  static CupertinoThemeData buildCupertinoTheme({
    required Color primaryColor, // 主要颜色
    Brightness brightness = Brightness.light, // 强制指定亮色主题或黑色主题
    bool boldText = true, // 是否要全局加粗文字
  }) {
    var textTheme = const CupertinoThemeData().textTheme;
    return CupertinoThemeData(
      primaryColor: primaryColor,
      textTheme: boldText
          ? CupertinoTextThemeData(
              textStyle:
                  textTheme.textStyle.copyWith(fontWeight: FontWeight.w500),
              tabLabelTextStyle:
                  textTheme.tabLabelTextStyle.copyWith(fontSize: 12),
              navActionTextStyle: textTheme.navActionTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: primaryColor,
              ),
            )
          : null,
    );
  }

  /// 显示半透明状态栏
  static void showTranslucenceStatusBar() {
    CommonUtil.delayed(200, () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(0, 0, 0, 200)));
    });
  }

  /// 隐藏半透明状态栏
  static void hideTranslucenceStatusBar() {
    CommonUtil.delayed(200, () {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Color.fromRGBO(0, 0, 0, 0)));
    });
  }
}

/// MyApp主题数据
class MyThemeData {
  final AppType appType;

  final Color primaryColor;
  final Color successColor;
  final Color warningColor;
  final Color errorColor;
  final Color infoColor;

  MyThemeData({
    required this.appType,
    required this.primaryColor,
    required this.successColor,
    required this.warningColor,
    required this.errorColor,
    required this.infoColor,
  });
}

/// 用于向子组件共享的表单数据
class _MyThemeInheritedWidget extends InheritedWidget {
  const _MyThemeInheritedWidget({
    required super.child,
    required this.themeData,
  });

  final MyThemeData themeData;

  @override
  bool updateShouldNotify(_MyThemeInheritedWidget oldWidget) {
    return true;
  }
}

class MyApp extends StatelessWidget {
  /// 构建Android Material2风格的App
  const MyApp.material2({
    super.key,
    this.title = '',
    this.home,
    this.router,
    this.primaryColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.infoColor,
    this.boldText = true,
    this.theme,
    this.darkTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.bottomNavigationType,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.translucenceStatusBar = true,
    this.locale = const Locale('zh', 'CN'),
  })  : assert(
            (home != null && router == null) ||
                (home == null && router != null),
            'home和router选项必须二选一'),
        _appType = AppType.material2,
        cupertinoTheme = null;

  /// 构建Android Material3风格的App
  const MyApp.material3({
    super.key,
    this.title = '',
    this.home,
    this.router,
    this.primaryColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.infoColor,
    this.boldText = true,
    this.theme,
    this.darkTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.bottomNavigationType,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.locale = const Locale('zh', 'CN'),
  })  : assert(
            (home != null && router == null) ||
                (home == null && router != null),
            'home和router选项必须二选一'),
        _appType = AppType.material3,
        translucenceStatusBar = false,
        cupertinoTheme = null;

  /// 构建IOS风格的App
  const MyApp.cupertino({
    super.key,
    this.title = '',
    this.home,
    this.router,
    this.primaryColor,
    this.successColor,
    this.warningColor,
    this.errorColor,
    this.infoColor,
    this.boldText = true,
    this.cupertinoTheme,
    this.localizationsDelegates,
    this.supportedLocales,
    this.bottomNavigationType,
    this.onlyHorizontalMode = false,
    this.onlyVerticalMode = false,
    this.locale = const Locale('zh', 'CN'),
  })  : assert(
            (home != null && router == null) ||
                (home == null && router != null),
            'home和router选项必须二选一'),
        _appType = AppType.cupertino,
        theme = null,
        darkTheme = null,
        translucenceStatusBar = false;

  /// app类型
  final AppType _appType;

  /// App标题，默认空
  final String title;

  /// 直接为App提供首屏组件，home和router二选一
  final Widget? home;

  /// 基于[GoRouter]的router配置，支持(路由拦截、深度链接、命名路由)等功能
  final GoRouter? router;

  /// 主题颜色
  final Color? primaryColor;
  final Color? successColor;
  final Color? warningColor;
  final Color? errorColor;
  final Color? infoColor;

  /// 是否全局加粗文字，默认true，设置为false将使用flutter默认配置
  final bool boldText;

  /// Material亮色主题
  final ThemeData? theme;

  /// 当设备设置为黑暗模式时App使用的主题，默认策略和flutter保持一致：[Brightness.light]。
  ///
  /// 如果你需要为app适配黑暗模式，请指定[Brightness.dark]。
  ///
  /// 注意：如果你使用自定义theme，同时需要响应式更新Theme，请使用Obx进行包裹，否则你无法实现响应式更新Theme。
  ///
  /// 示例：
  /// ```dart
  /// Obx(() => MyApp(
  ///   router,
  ///   darkTheme: ThemeController.of.buildMaterialThemeData(
  ///     brightness: Brightness.dark,
  ///   ),
  /// ))
  /// ```
  final ThemeData? darkTheme;

  /// ios主题
  final CupertinoThemeData? cupertinoTheme;

  /// 国际化配置，你传入的新配置将合并至默认配置，默认配置为：
  /// ```dart
  /// [
  ///  GlobalWidgetsLocalizations.delegate,
  ///  GlobalMaterialLocalizations.delegate,
  ///  GlobalCupertinoLocalizations.delegate,
  /// ]
  /// ```
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  /// 支持的语言数组，你传入的新配置将合并至默认配置，默认配置为：
  /// ```dart
  /// [
  ///   Locale('zh', 'CH'),
  ///   Locale('en', 'US'),
  /// ]
  final Iterable<Locale>? supportedLocales;

  /// 默认的语言，默认为：const Locale('zh', 'CN')
  final Locale locale;

  /// 底部导航栏类型
  final BottomNavigationType? bottomNavigationType;

  /// 是否只允许横屏展示
  final bool onlyHorizontalMode;

  /// 是否只允许竖屏展示
  final bool onlyVerticalMode;

  /// material2主题是否显示半透明状态栏
  final bool translucenceStatusBar;

  @override
  Widget build(BuildContext context) {
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
    MyThemeData myThemeData = MyThemeData(
      appType: _appType,
      primaryColor: primaryColor ?? _primaryColor,
      successColor: successColor ?? _successColor,
      warningColor: warningColor ?? _warningColor,
      errorColor: errorColor ?? _errorColor,
      infoColor: infoColor ?? _infoColor,
    );
    var $localizationsDelegates = CommonUtil.concatArray(
            (localizationsDelegates ?? []).toList(), _localizationsDelegates)
        .map((e) => e);
    var $supportedLocales = CommonUtil.concatArray(
            (supportedLocales ?? []).toList(), _supportedLocales)
        .map((e) => e);
    late Widget appWidget;
    switch (myThemeData.appType) {
      case AppType.material2:
        appWidget = buildMaterial2App(
          context,
          myThemeData: myThemeData,
          localizationsDelegates: $localizationsDelegates,
          supportedLocales: $supportedLocales,
        );
      case AppType.material3:
        appWidget = buildMaterial3App(
          context,
          myThemeData: myThemeData,
          localizationsDelegates: $localizationsDelegates,
          supportedLocales: $supportedLocales,
        );
      case AppType.cupertino:
        appWidget = buildCupertinoApp(
          context,
          myThemeData: myThemeData,
          localizationsDelegates: $localizationsDelegates,
          supportedLocales: $supportedLocales,
        );
    }
    return buildMyAppTheme(context, child: appWidget, myThemeData: myThemeData);
  }

  Widget buildMyAppTheme(
    BuildContext context, {
    required Widget child,
    required MyThemeData myThemeData,
  }) {
    return _MyThemeInheritedWidget(
      themeData: myThemeData,
      child: child,
    );
  }

  Widget buildMaterial2App(
    BuildContext context, {
    required MyThemeData myThemeData,
    required Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required Iterable<Locale> supportedLocales,
  }) {
    translucenceStatusBar
        ? MyTheme.showTranslucenceStatusBar()
        : MyTheme.hideTranslucenceStatusBar();
    if (home != null) {
      return MaterialApp(
        title: title,
        theme: theme ??
            MyTheme.buildMaterial2ThemeData(
              primaryColor: myThemeData.primaryColor,
            ),
        darkTheme: darkTheme ??
            MyTheme.buildMaterial2ThemeData(
              primaryColor: myThemeData.primaryColor,
              brightness: Brightness.dark,
            ),
        home: home,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    } else {
      return MaterialApp.router(
        title: title,
        theme: theme ??
            MyTheme.buildMaterial2ThemeData(
              primaryColor: myThemeData.primaryColor,
            ),
        darkTheme: darkTheme ??
            MyTheme.buildMaterial2ThemeData(
              primaryColor: myThemeData.primaryColor,
              brightness: Brightness.dark,
            ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    }
  }

  Widget buildMaterial3App(
    BuildContext context, {
    required MyThemeData myThemeData,
    required Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required Iterable<Locale> supportedLocales,
  }) {
    MyTheme.hideTranslucenceStatusBar();
    if (home != null) {
      return MaterialApp(
        title: title,
        theme: theme ??
            MyTheme.buildMaterial3ThemeData(
              primaryColor: myThemeData.primaryColor,
            ),
        darkTheme: darkTheme ??
            MyTheme.buildMaterial3ThemeData(
              primaryColor: myThemeData.primaryColor,
              brightness: Brightness.dark,
            ),
        home: home,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    } else {
      return MaterialApp.router(
        title: title,
        theme: theme ??
            MyTheme.buildMaterial3ThemeData(
              primaryColor: myThemeData.primaryColor,
            ),
        darkTheme: darkTheme ??
            MyTheme.buildMaterial3ThemeData(
              primaryColor: myThemeData.primaryColor,
              brightness: Brightness.dark,
            ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    }
  }

  Widget buildCupertinoApp(
    BuildContext context, {
    required MyThemeData myThemeData,
    required Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates,
    required Iterable<Locale> supportedLocales,
  }) {
    MyTheme.hideTranslucenceStatusBar();
    if (home != null) {
      return CupertinoApp(
        title: title,
        theme: cupertinoTheme ??
            MyTheme.buildCupertinoTheme(
              primaryColor: myThemeData.primaryColor,
              boldText: boldText,
            ),
        home: home,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    } else {
      return CupertinoApp.router(
        title: title,
        theme: cupertinoTheme ??
            MyTheme.buildCupertinoTheme(
              primaryColor: myThemeData.primaryColor,
              boldText: boldText,
            ),
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: initBuilder(),
      );
    }
  }
}

/// MaterialApp、CupertinoApp的 builder 参数，初始化全局toast、解决modal_bottom_sheet在高版本安卓系统上动画丢失问题
TransitionBuilder initBuilder() => (context, child) {
      globalContext ??= context;
      if (globalContext != context) {
        return child!;
      } else {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) {
              toast.init(context);
              return MediaQuery(
                // 解决modal_bottom_sheet在高版本安卓系统上动画丢失
                data: MediaQuery.of(context)
                    .copyWith(accessibleNavigation: false),
                child: child!,
              );
            }),
          ],
        );
      }
    };
