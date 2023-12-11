import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart'
    as modal_bottom_sheet;
import 'package:my_flutter/my_flutter.dart';

enum RoutePageType {
  /// MaterialPageRoute
  material,

  /// CupertinoPageRoute
  cupertino,
}

class RouterUtil {
  RouterUtil._();

  /// 跳转新页面的动画类型
  static RoutePageType routePageType = RoutePageType.material;

  /// 跳转到新页面
  static Future<T?> to<T>(
    Widget page, {
    BuildContext? context,
    bool rootNavigator = false,
    bool fullscreenDialog = false,
    bool noTransition = false,
    PageTransitionType? pageTransitionType,
  }) async {
    late Route<T> routePage;
    if (noTransition) {
      return await Navigator.of(
        context ?? navigatorKey.currentContext!,
      ).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    } else {
      if (pageTransitionType == null) {
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
        routePage = PageTransition(child: page, type: pageTransitionType);
      }
      return await Navigator.of(
        context ?? navigatorKey.currentContext!,
        rootNavigator: rootNavigator,
      ).push<T>(routePage);
    }
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

  /// 重定向页面，先跳转新页面，再删除之前的页面
  static Future<T?> redirect<T>(
    Widget page, {
    bool rootNavigator = false,
    bool fullscreenDialog = false,
    BuildContext? context,
    RouteSettings? settings,
  }) async {
    return await Navigator.of(
      context ?? navigatorKey.currentContext!,
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
    Navigator.of(context ?? navigatorKey.currentContext!).pushAndRemoveUntil(
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
    Navigator.of(context ?? navigatorKey.currentContext!).popUntil(
      ModalRoute.withName(routePath),
    );
  }

  /// 进入新的页面并删除之前所有路
  static void pushAndPopAll(
    Widget page, {
    BuildContext? context,
  }) async {
    Navigator.of(context ?? navigatorKey.currentContext!).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => page,
      ),
      (route) => false,
    );
  }

  /// 进入包含Cupertino弹窗页面
  static Future<T?> toMaterialWithModalsPage<T>(
    Widget page, {
    BuildContext? context,
  }) async {
    return await Navigator.of(
      context ?? navigatorKey.currentContext!,
    ).push<T>(
      modal_bottom_sheet.MaterialWithModalsPageRoute(
        builder: (context) => page,
      ),
    );
  }

  /// 进入包含cupertino弹窗页面(modal_bottom_sheet)，如果你希望进入的页面弹出cupertino风格的弹窗(弹出弹窗页面会进行缩小)，则必须使用此函数进入新页面
  static Future<T?> pushModalsPage<T>(
    Widget page, {
    BuildContext? context,
    RouteSettings? settings,
  }) async {
    return await Navigator.of(context ?? navigatorKey.currentContext!).push<T>(
      CupertinoWithModalsPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
    );
  }

  static Future<T?> redirectModalsPage<T>(
    Widget page, {
    BuildContext? context,
    RouteSettings? settings,
  }) async {
    return await Navigator.of(context ?? navigatorKey.currentContext!)
        .pushReplacement(
      CupertinoWithModalsPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
    );
  }

  static void pushUntilModalsPage(
    Widget page,
    String routePath, {
    BuildContext? context,
    RouteSettings? settings,
  }) async {
    Navigator.of(context ?? navigatorKey.currentContext!).pushAndRemoveUntil(
      CupertinoWithModalsPageRoute(
        builder: (context) => page,
        settings: settings,
      ),
      ModalRoute.withName(routePath),
    );
  }
}

/// 继承cupertino路由页面过渡动画，再此基础上加入页面缩放动画
class CupertinoWithModalsPageRoute<T> extends CupertinoPageRoute<T> {
  CupertinoWithModalsPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
            settings: settings,
            fullscreenDialog: fullscreenDialog,
            builder: builder,
            maintainState: maintainState);

  modal_bottom_sheet.ModalSheetRoute? _nextModalRoute;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return (nextRoute is MaterialPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoWithModalsPageRoute &&
            !nextRoute.fullscreenDialog) ||
        (nextRoute is modal_bottom_sheet.ModalSheetRoute);
  }

  @override
  void didChangeNext(Route? nextRoute) {
    if (nextRoute is modal_bottom_sheet.ModalSheetRoute) {
      _nextModalRoute = nextRoute;
    }

    super.didChangeNext(nextRoute);
  }

  @override
  bool didPop(T? result) {
    _nextModalRoute = null;
    return super.didPop(result);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    final nextRoute = _nextModalRoute;
    if (nextRoute != null) {
      if (!secondaryAnimation.isDismissed) {
        final fakeSecondaryAnimation =
            Tween<double>(begin: 0, end: 0).animate(secondaryAnimation);
        final defaultTransition = theme.buildTransitions<T>(
            this, context, animation, fakeSecondaryAnimation, child);
        return nextRoute.getPreviousRouteTransition(
            context, secondaryAnimation, defaultTransition);
      } else {
        _nextModalRoute = null;
      }
    }

    return theme.buildTransitions<T>(
        this, context, animation, secondaryAnimation, child);
  }
}
