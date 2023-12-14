import 'package:flutter/cupertino.dart';

class RouterUtil {
  RouterUtil._();

  /// 跳转到新页面
  static Future<T?> to<T>(
    BuildContext context,
    Widget page, {
    bool rootNavigator = false,
    bool fullscreenDialog = false,
    bool noTransition = false,
  }) async {
    if (noTransition) {
      return await Navigator.of(
        context,
        rootNavigator: rootNavigator,
      ).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      return await Navigator.of(
        context,
        rootNavigator: rootNavigator,
      ).push<T>(CupertinoPageRoute(
        builder: (context) => page,
        fullscreenDialog: fullscreenDialog,
      ));
    }
  }

  /// 返回上一页
  static void back<T>(
    BuildContext context, {
    T? data,
    int backNum = 1,
  }) async {
    for (int i = 0; i < backNum; i++) {
      Navigator.of(context).pop(data);
    }
  }

  /// 重定向页面，先跳转新页面，再删除之前的页面
  static Future<T?> redirect<T>(
    BuildContext context,
    Widget page, {
    bool rootNavigator = false,
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) async {
    return await Navigator.of(
      context,
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
    BuildContext context,
    Widget page,
    String routePath, {
    RouteSettings? settings,
  }) async {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
      ModalRoute.withName(routePath),
    );
  }

  /// 原理和pushUntil一样，只不过这是退出到指定位置
  static void popUntil(BuildContext context, String routePath) async {
    Navigator.of(context).popUntil(
      ModalRoute.withName(routePath),
    );
  }

  /// 进入新的页面并删除之前所有路
  static void pushAndPopAll(BuildContext context, Widget page) async {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );
  }
}
