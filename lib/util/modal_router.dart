import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal_bottom_sheet;
import 'package:my_flutter/my_flutter.dart';

/// 模态路由工具类，对modal_bottom_sheet进行的封装
class ModalRouterUtil {
  ModalRouterUtil._();

  /// 进入包含Cupertino弹窗页面
  static Future<T?> toMaterialWithModalsPage<T>(
    Widget page, {
    BuildContext? context,
  }) async {
    return await Navigator.of(
      context ?? globalContext,
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
    return await Navigator.of(context ?? globalContext).push<T>(
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
    return await Navigator.of(context ?? globalContext).pushReplacement(
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
    Navigator.of(context ?? globalContext).pushAndRemoveUntil(
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
  }) : super(settings: settings, fullscreenDialog: fullscreenDialog, builder: builder, maintainState: maintainState);

  modal_bottom_sheet.ModalSheetRoute? _nextModalRoute;

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return (nextRoute is MaterialPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoPageRoute && !nextRoute.fullscreenDialog) ||
        (nextRoute is CupertinoWithModalsPageRoute && !nextRoute.fullscreenDialog) ||
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
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    PageTransitionsTheme theme = Theme.of(context).pageTransitionsTheme;
    final nextRoute = _nextModalRoute;
    if (nextRoute != null) {
      if (!secondaryAnimation.isDismissed) {
        final fakeSecondaryAnimation = Tween<double>(begin: 0, end: 0).animate(secondaryAnimation);
        final defaultTransition = theme.buildTransitions<T>(this, context, animation, fakeSecondaryAnimation, child);
        return nextRoute.getPreviousRouteTransition(context, secondaryAnimation, defaultTransition);
      } else {
        _nextModalRoute = null;
      }
    }

    return theme.buildTransitions<T>(this, context, animation, secondaryAnimation, child);
  }
}
