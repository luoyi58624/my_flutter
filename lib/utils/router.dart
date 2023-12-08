import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:my_flutter/my_flutter.dart';

enum RoutePageType {
  /// MaterialPageRoute
  material,

  /// CupertinoPageRoute
  cupertino,
}

/// 跳转新页面的动画类型
RoutePageType routePageType = RoutePageType.material;

class RouterUtil {
  RouterUtil._();

  /// 跳转到新页面
  static Future<T?> to<T>(
    Widget page, {
    BuildContext? context,
    bool rootNavigator = false,
    bool fullscreenDialog = false,
    PageTransitionType? transition,
  }) async {
    late Route<T> routePage;
    if (transition == null) {
      switch (routePageType) {
        case RoutePageType.material:
          routePage = MaterialPageRoute(
            builder: (context) => page,
            fullscreenDialog: fullscreenDialog,
          );
        case RoutePageType.cupertino:
          routePage = CupertinoPageRoute(
            builder: (context) => page,
            fullscreenDialog: fullscreenDialog,
          );
      }
    } else {
      routePage = PageTransition(child: page, type: transition);
    }
    return await Navigator.of(
      context ?? navigatorKey.currentContext!,
      rootNavigator: rootNavigator,
    ).push<T>(routePage);
  }

  /// 返回上一页
  static void back<T>({
    BuildContext? context,
    T? data,
    int backNum = 1,
  }) async {
    for (int i = 0; i < backNum; i++) {
      Navigator.of(context ?? navigatorKey.currentContext!).pop(data);
    }
  }

  /// 返回到指定页面，指定页面必须为声明式路由字符串path
  static void popUntil<T>(
    String routePath, {
    BuildContext? context,
  }) async {
    Navigator.popUntil(context ?? navigatorKey.currentContext!,
        ModalRoute.withName(routePath));
  }

  /// 进入包含Cupertino弹窗页面
  static Future<T?> toMaterialWithModalsPage<T>(
    Widget page, {
    BuildContext? context,
  }) async {
    return await Navigator.of(
      context ?? navigatorKey.currentContext!,
    ).push<T>(
      MaterialWithModalsPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
