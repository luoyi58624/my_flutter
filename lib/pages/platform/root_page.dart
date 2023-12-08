import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino/index.dart';
import 'package:my_flutter/pages/material/index.dart';

/// material导航页面
class PlatformRootPage extends StatefulWidget {
  const PlatformRootPage({
    super.key,
    required this.pages,
    this.useMaterial2NavigationBar = false,
  }) : assert(pages.length >= 2);

  /// 是否使用material2风格的底部导航栏，默认false
  final bool useMaterial2NavigationBar;

  /// 导航页面数组，必须至少包含2个页面
  final List<RootPageModel> pages;

  @override
  State<PlatformRootPage> createState() => _PlatformRootPageState();
}

class _PlatformRootPageState extends State<PlatformRootPage> {
  late PlatformTabController tabController;
  int tabbarIndex = 0;
  bool allowQuit = false; // 双击返回键退出应用

  @override
  void initState() {
    super.initState();
    tabController = PlatformTabController(
      initialIndex: 0,
    );
  }

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
                ToastUtil.showToast('请再按一次退出应用');
                Timer(const Duration(seconds: 2), () {
                  allowQuit = false;
                });
                return false;
              }
            },
      child: CommonUtil.isApplePlatform
          ? CupertinoRootPage(pages: widget.pages)
          : MaterialRootPage(
              pages: widget.pages,
              useMaterial2NavigationBar: widget.useMaterial2NavigationBar,
            ),
    );
  }
}
