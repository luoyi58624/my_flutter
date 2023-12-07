import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

/// cupertino导航页面
class CupertinoRootPage extends StatefulWidget {
  const CupertinoRootPage({
    super.key,
    required this.pages,
    this.tabbarInactiveColor = const CupertinoDynamicColor.withBrightness(
      color: Color(0xFF222222),
      darkColor: CupertinoColors.white,
    ),
  }) : assert(pages.length >= 2);

  /// 页面列表
  final List<RootPageModel> pages;

  /// tabbar未激活颜色
  final CupertinoDynamicColor tabbarInactiveColor;

  @override
  State<CupertinoRootPage> createState() => _CupertinoRootPageState();
}

class _CupertinoRootPageState extends State<CupertinoRootPage> {
  int tabbarIndex = 0;
  bool allowQuit = false; // 双击返回键退出应用

  /// 每个tabbar的导航key
  Map<int, GlobalKey<NavigatorState>> tabbarNavigatorKey = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.pages.length; i++) {
      tabbarNavigatorKey[i] = GlobalKey<NavigatorState>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: CommonUtil.isApplePlatform
          ? null
          : () async {
              NavigatorState navigatorState =
                  tabbarNavigatorKey[tabbarIndex]!.currentState!;
              if (navigatorState.canPop()) {
                navigatorState.pop();
                return false;
              } else {
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
              }
            },
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: tabbarIndex,
          iconSize: 24,
          inactiveColor: widget.tabbarInactiveColor,
          items: widget.pages
              .map((e) => BottomNavigationBarItem(
                    label: e.title,
                    icon: Icon(e.icon),
                  ))
              .toList(),
          onTap: (index) {
            setState(() {
              tabbarIndex = index;
            });
          },
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
              navigatorKey: tabbarNavigatorKey[index],
              builder: (BuildContext context) {
                return widget.pages[index].widget;
              });
        },
      ),
    );
  }
}
