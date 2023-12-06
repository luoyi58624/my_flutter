import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

/// cupertino风格根页面
class CupertinoRootPage extends StatefulWidget {
  const CupertinoRootPage({
    super.key,
    required this.pages,
  });

  final List<RootPageModel> pages;

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
          inactiveColor: const Color.fromARGB(200, 0, 0, 0),
          items: widget.pages
              .map((e) => BottomNavigationBarItem(
                    label: e.label,
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
                return widget.pages[index].page;
              });
        },
      ),
    );
  }
}
