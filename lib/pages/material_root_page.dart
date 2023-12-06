import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

/// material风格根页面
class MaterialRootPage extends StatefulWidget {
  const MaterialRootPage({
    super.key,
    required this.pages,
    this.useBottomNavigationBar2 = false,
  });

  final bool useBottomNavigationBar2;
  final List<RootPageModel> pages;

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
          children: widget.pages.map((e) => e.page).toList(),
        ),
        bottomNavigationBar:
            widget.useBottomNavigationBar2 ? navigationBar2 : navigationBar3,
      ),
    );
  }

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
      selectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
      type: BottomNavigationBarType.fixed,
      items: widget.pages
          .map((e) => BottomNavigationBarItem(
                icon: Icon(e.icon),
                label: e.label,
              ))
          .toList());

  Widget get navigationBar3 => Theme(
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
              tabbarIndex = index;
            });
          },
          selectedIndex: tabbarIndex,
          destinations: widget.pages
              .map((e) => NavigationDestination(
                    icon: Icon(e.icon),
                    label: e.label,
                  ))
              .toList()));
}
