import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:package/index.dart';

/// 创建包含多个一级页面的根页面集合，它是基于go_router的[StatefulShellRoute.indexedStack]实现。
///
/// 它实现了选项卡式导航(并行导航)、路由懒加载(如果你直接使用[IndexedStack]构建页面，它会直接构建所有的子组件)等功能。
RouteBase createRootPage(
  List<RootPageModel> rootPages, {
  // 根页面设置父级路由path
  String? parentPath,
  // material3导航栏高度
  double material3NavbarHeight = 72,
  // cupertino导航栏高度
  double cupertinoNavbarHeight = 50,
  // 自定义底部导航栏组件，注意：需要设置 ThemeController.of.bottomNavigationType.value = BottomNavigationType.custom.name 才会生效
  Widget Function(StatefulNavigationShell navigationShell)? bottomNavbarWidget,
  // 自定义根页面组件，具体实现参照_RootPage即可，逻辑很简单
  Widget Function(StatefulNavigationShell navigationShell)? rootPageWidget,
}) {
  Get.put(BottomNavigationController._(rootPages, parentPath));
  return StatefulShellRoute.indexedStack(
    parentNavigatorKey: rootNavigatorKey,
    builder: (context, state, navigationShell) => rootPageWidget == null
        ? _RootPage(
            navigationShell,
            rootPages,
            material3NavbarHeight: material3NavbarHeight,
            cupertinoNavbarHeight: cupertinoNavbarHeight,
          )
        : rootPageWidget(navigationShell),
    branches: rootPages
        .map(
          (e) => StatefulShellBranch(
            routes: [
              GoRoute(
                path: CommonUtil.joinParentPath(e.path, parentPath),
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
  final String? _parentPath;

  /// 底部导航徽标，key-路由path，value-徽标数值
  final badge = useLocalMapObs<int>({}, 'bottom_navigation_badge');

  BottomNavigationController._(this._rootPages, [this._parentPath]) {
    for (var page in _rootPages) {
      if (badge[page.path] == null) {
        badge[CommonUtil.joinParentPath(page.path, _parentPath)] = 0;
      }
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
  const _RootPage(
    this.navigationShell,
    this.pages, {
    this.material3NavbarHeight,
    this.cupertinoNavbarHeight,
    this.bottomNavbarWidget,
  });

  final StatefulNavigationShell navigationShell;

  /// 导航页面数组，必须至少包含2个页面
  final List<RootPageModel> pages;

  /// material3导航栏高度
  final double? material3NavbarHeight;

  /// cupertino导航栏高度
  final double? cupertinoNavbarHeight;

  /// 自定义底部导航栏
  final Widget Function(StatefulNavigationShell navigationShell)? bottomNavbarWidget;

  @override
  State<_RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<_RootPage> {
  final BottomNavigationController controller = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ExitInterceptWidget(
      child: Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: Obx(() {
          String $type = themeController.bottomNavigationType.value;
          if ($type == BottomNavigationType.auto.name) {
            return themeController.appType.value == AppType.material.name
                ? (themeController.useMaterial3.value ? material3Tabbar : material2Tabbar)
                : cupertinoTabbar;
          } else if ($type == BottomNavigationType.custom.name) {
            // assert(widget.bottomNavbarWidget != null, '请在createRootPage函数中传递bottomNavbarWidget自定义导航栏参数');
            return widget.bottomNavbarWidget != null
                ? widget.bottomNavbarWidget!(widget.navigationShell)
                : const SizedBox(height: 64, child: Placeholder());
          } else if ($type == BottomNavigationType.material2.name) {
            return material2Tabbar;
          } else if ($type == BottomNavigationType.material3.name) {
            return material3Tabbar;
          } else if ($type == BottomNavigationType.cupertino.name) {
            return cupertinoTabbar;
          } else {
            throw Exception('未知底部导航栏类型');
          }
        }),
      ),
    );
  }

  /// material2底部导航栏
  Widget get material2Tabbar => BottomNavigationBar(
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
        selectedItemColor: themeController.primaryColor.value,
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

  /// material3底部导航栏
  Widget get material3Tabbar => Theme(
        data: Theme.of(context).copyWith(
          textTheme: const TextTheme(
            labelMedium: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              widget.navigationShell.goBranch(index);
            });
          },
          selectedIndex: widget.navigationShell.currentIndex,
          height: widget.material3NavbarHeight,
          destinations: widget.pages
              .map((e) => NavigationDestination(
                    icon: Obx(
                      () => BadgeWidget(
                        bagde: controller.badge.value[e.path],
                        child: Icon(e.icon),
                      ),
                    ),
                    label: e.title,
                  ))
              .toList(),
        ),
      );

  /// cupertino底部导航栏
  Widget get cupertinoTabbar => CupertinoTabBar(
        onTap: (index) {
          setState(() {
            widget.navigationShell.goBranch(index);
          });
        },
        currentIndex: widget.navigationShell.currentIndex,
        height: widget.cupertinoNavbarHeight!,
        iconSize: 26,
        items: widget.pages
            .map((e) => BottomNavigationBarItem(
                  label: e.title,
                  icon: Icon(e.icon),
                ))
            .toList(),
      );
}
