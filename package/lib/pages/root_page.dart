import 'dart:async';

import 'package:flutter/material.dart';

import 'package:package/index.dart';

/// 创建包含多个一级页面的根页面集合，它是基于go_router的[StatefulShellRoute.indexedStack]实现。
///
/// 它实现了嵌套路由、路由懒加载(如果你直接使用[IndexedStack]构建页面，它会直接构建所有的子组件)等功能。
RouteBase createRootPage(List<RootPageModel> rootPages) {
  Get.put(BottomNavigationController._(rootPages));
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        _RootPage(navigationShell, rootPages),
    branches: rootPages
        .map(
          (e) => StatefulShellBranch(
            routes: [
              GoRoute(
                path: e.path,
                builder: (context, state) => e.page,
              ),
            ],
          ),
        )
        .toList(),
  );
}

/// 底部导航栏控制器，当你使用[createRootPage]函数创建包含多个一级页面的app时，将会注入构造器，
/// 你可以在任何地方通过[BottomNavigationController.of]直接获取它的实例。
class BottomNavigationController extends GetxController {
  static BottomNavigationController get of => Get.find();

  final List<RootPageModel> _rootPages;

  /// 底部导航徽标，key-路由path，value-徽标数值
  final badge = useLocalMapObs<int>({}, 'bottom_navigation_badge');

  BottomNavigationController._(this._rootPages) {
    for (var page in _rootPages) {
      if (badge[page.path] == null) badge[page.path] = 0;
    }
  }

  /// 设置徽标数字
  void setBadge(String path, int badgeNum) {
    badge.update(path, (value) => badgeNum);
  }

  /// 徽标数字增加指定数值
  void addBadge(String path, int badgeNum) {
    badge.update(path, (value) => value + badgeNum);
  }

  /// 徽标数字减少指定数值
  void subtractBadge(String path, int badgeNum) {
    badge.update(path, (value) => value - badgeNum);
  }

  /// 清除徽标
  void clearBadge(String path) {
    badge.update(path, (value) => 0);
  }
}

class _RootPage extends StatefulWidget {
  const _RootPage(this.navigationShell, this.pages);

  final StatefulNavigationShell navigationShell;

  /// 导航页面数组，必须至少包含2个页面
  final List<RootPageModel> pages;

  @override
  State<_RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<_RootPage> {
  bool allowQuit = false; // 双击返回键退出应用
  final BottomNavigationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: allowQuit,
      onPopInvoked: (_) async {
        if (!allowQuit) {
          setState(() {
            allowQuit = true;
          });
          ToastUtil.showToast('请再按一次退出应用');
          Timer(const Duration(seconds: 2), () {
            setState(() {
              allowQuit = false;
            });
          });
        }
      },
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: navigationBar2,
      ),
    );
  }

  /// material2风格的底部导航栏
  Widget get navigationBar2 => BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            widget.navigationShell.goBranch(index);
          });
        },
        currentIndex: widget.navigationShell.currentIndex,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        iconSize: 26,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w900,
        ),
        type: BottomNavigationBarType.fixed,
        items: widget.pages
            .map((e) => BottomNavigationBarItem(
                  icon: Obx(
                    () => BadgeWidget(
                      bagde: controller.badge.value[e.path],
                      child: Icon(e.icon),
                    ),
                  ),
                  label: e.title,
                ))
            .toList(),
      );
}
