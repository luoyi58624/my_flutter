import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package/index.dart';

class RouterUtil {
  RouterUtil._();

  /// 跳转到新页面
  static Future<T?> to<T>(
    Widget page, {
    BuildContext? context,
    bool rootNavigator = false,
    bool fullscreenDialog = false,
    bool noTransition = false,
    bool forceMaterial = false,
    bool forceCupertino = false,
  }) async {
    if (noTransition) {
      return await Navigator.of(
        context ?? rootContext,
        rootNavigator: rootNavigator,
      ).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      if (forceMaterial) {
        return await Navigator.of(
          context ?? rootContext,
          rootNavigator: rootNavigator,
        ).push<T>(MaterialPageRoute(
          builder: (context) => page,
          fullscreenDialog: fullscreenDialog,
        ));
      }
      if (forceCupertino) {
        return await Navigator.of(
          context ?? rootContext,
          rootNavigator: rootNavigator,
        ).push<T>(CupertinoPageRoute(
          builder: (context) => page,
          fullscreenDialog: fullscreenDialog,
        ));
      }
      if (ThemeController.of.appType.value == AppType.cupertino.name) {
        return await Navigator.of(
          context ?? rootContext,
          rootNavigator: rootNavigator,
        ).push<T>(CupertinoPageRoute(
          builder: (context) => page,
          fullscreenDialog: fullscreenDialog,
        ));
      } else {
        return await Navigator.of(
          context ?? rootContext,
          rootNavigator: rootNavigator,
        ).push<T>(MaterialPageRoute(
          builder: (context) => page,
          fullscreenDialog: fullscreenDialog,
        ));
      }
    }
  }

  /// 返回上一页
  static void back<T>({
    BuildContext? context,
    T? data,
    int backNum = 1,
  }) async {
    var $context = (context ?? rootContext);
    for (int i = 0; i < backNum; i++) {
      if ($context.canPop()) {
        // Navigator.of($context).pop(data);
        $context.pop(data);
      }
    }
  }

  /// 重定向页面，先跳转新页面，再删除之前的页面
  static Future<T?> redirect<T>(
    Widget page, {
    BuildContext? context,
    bool rootNavigator = false,
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) async {
    // if (context != null) {
    //   context.go(location);
    // }
    return await Navigator.of(
      context ?? rootContext,
      rootNavigator: rootNavigator,
    ).pushReplacement(CupertinoPageRoute(
      builder: (context) => page,
      settings: settings,
      fullscreenDialog: fullscreenDialog,
    ));
  }

  /// 跳转新页面，同时删除之前所有的路由，直到指定的routePath。
  /// 讲人话就是：如果你想跳转一个新页面，同时希望这个新页面的上一级是首页，那么就设置routePath = '/'，
  /// 它会先跳转到新的页面，再删除从首页开始后的全部路由。
  ///
  /// 当然，一般app有多个tabbar页面，它们都属于根页面，你若要指定tabbar页面还需要自己做处理，
  /// 你可以使用 "事件总线" 或者 "全局状态"。
  static void pushUntil(
    Widget page,
    String routePath, {
    BuildContext? context,
    RouteSettings? settings,
  }) async {
    Navigator.of(context ?? rootContext).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
      ModalRoute.withName(routePath),
    );
  }

  /// 原理和pushUntil一样，只不过这是退出到指定位置
  static void popUntil(
    String routePath, {
    BuildContext? context,
  }) async {
    Navigator.of(context ?? rootContext).popUntil(
      ModalRoute.withName(routePath),
    );
  }

  /// 进入新的页面并删除之前所有路
  static void pushAndPopAll(
    Widget page, {
    BuildContext? context,
  }) async {
    Navigator.of(context ?? rootContext).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );
  }
}
