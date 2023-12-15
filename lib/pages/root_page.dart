import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../my_flutter.dart';

/// 创建根页面
RouteBase createRootPage(List<RootPageModel> rootPages) {
  Get.put(RootPageController._(rootPages));
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

class RootPageController extends GetxController {
  static RootPageController get of => Get.find();
  static String localKey = 'bottom_navigation_badge';

  final List<RootPageModel> _rootPages;
  final bottomNavigationBadges = RxMap<String, int>();

  RootPageController._(this._rootPages) {
    Map<String, int> badgeMap = {};
    for (var page in _rootPages) {
      badgeMap[page.path] = 0;
    }
    ever(bottomNavigationBadges, (v) {
      localStorage.setItem(localKey, jsonEncode(v));
    });
    bottomNavigationBadges.value =
        localStorage.getItem<Map<String, int>>(localKey, badgeMap);
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
  final RootPageController controller = Get.find();

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
                      bagde: controller.bottomNavigationBadges.value[e.path],
                      child: Icon(e.icon),
                    ),
                  ),
                  label: e.title,
                ))
            .toList(),
      );
}
