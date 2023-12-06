import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    bool rootNavigator = false,
    bool fullscreenDialog = false,
  }) async {
    late Route<T> routePage;
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
    return await Navigator.of(
      context,
      rootNavigator: rootNavigator,
    ).push<T>(routePage);
  }

  /// 返回上一页
  static void back<T>(BuildContext context, [T? result]) async {
    Navigator.of(context).pop(result);
  }

  /// 返回到指定页面，指定页面必须为声明式路由字符串path
  static void popUntil<T>(BuildContext context, String routePath) async {
    Navigator.popUntil(context, ModalRoute.withName(routePath));
  }

  /// 进入包含Cupertino弹窗页面
  static Future<T?> toMaterialWithModalsPage<T>(
      BuildContext context, Widget page) async {
    return await Navigator.of(context).push<T>(
      MaterialWithModalsPageRoute(
        builder: (context) => page,
      ),
    );
  }
}
