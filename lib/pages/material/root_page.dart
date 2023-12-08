import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

/// material导航页面
class MaterialRootPage extends StatefulWidget {
  const MaterialRootPage({
    super.key,
    required this.pages,
    this.useMaterial2NavigationBar = false,
    this.selectedTabColor,
    this.bottomNavigationBar,
  }) : assert(pages.length >= 2);

  /// 导航页面数组，必须至少包含2个页面
  final List<RootPageModel> pages;

  /// 是否使用material2风格的底部导航栏，默认false
  final bool useMaterial2NavigationBar;

  /// 选中的tabbar颜色，注意：仅限material2风格的导航栏
  final Color? selectedTabColor;

  /// 自定义底部导航栏
  final Widget? bottomNavigationBar;

  @override
  State<MaterialRootPage> createState() => _MaterialRootPageState();
}

class _MaterialRootPageState extends State<MaterialRootPage> {
  int tabbarIndex = 0;
  bool allowQuit = false; // 双击返回键退出应用

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: CommonUtil.isApplePlatform
          ? null
          : () async {
              if (allowQuit) {
                return true;
              } else {
                allowQuit = true;
                ToastUtils.showToast('请再按一次退出应用');
                Timer(const Duration(seconds: 2), () {
                  allowQuit = false;
                });
                return false;
              }
            },
      child: Scaffold(
        body: IndexedStack(
          index: tabbarIndex,
          children: widget.pages.map((e) => e.widget).toList(),
        ),
        bottomNavigationBar: widget.bottomNavigationBar ??
            (widget.useMaterial2NavigationBar
                ? navigationBar2
                : Theme.of(context).useMaterial3
                    ? navigationBar3
                    : navigationBar2),
      ),
    );
  }

  /// material2风格的底部导航栏
  Widget get navigationBar2 => BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            tabbarIndex = index;
          });
        },
        currentIndex: tabbarIndex,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        iconSize: 26,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        selectedItemColor:
            widget.selectedTabColor ?? Theme.of(context).colorScheme.primary,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w900,
        ),
        type: BottomNavigationBarType.fixed,
        items: widget.pages
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.title,
                ))
            .toList(),
      );

  /// material3风格的底部导航栏
  Widget get navigationBar3 => Theme(
        data: Theme.of(context).copyWith(
          textTheme: const TextTheme(
            labelMedium: TextStyle(
                // fontSize: 13,
                // fontWeight: FontWeight.w900,
                ),
          ),
        ),
        child: NavigationBar(
          height: 64,
          selectedIndex: tabbarIndex,
          onDestinationSelected: (int index) {
            setState(() {
              tabbarIndex = index;
            });
          },
          destinations: widget.pages
              .map((e) => NavigationDestination(
                    icon: Icon(e.icon),
                    label: e.title,
                  ))
              .toList(),
        ),
      );
}
