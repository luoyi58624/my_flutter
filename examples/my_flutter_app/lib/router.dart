import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'pages/root_page/component/index.dart';
import 'pages/root_page/home/index.dart';
import 'pages/root_page/my/index.dart';
import 'pages/root_page/template/index.dart';
import 'pages/root_page/util/index.dart';

final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const RootPage(rootPages),
    // ),
    createRootPage(const [
      RootPageModel('首页', '/', HomeRootPage(), icon: Icons.home),
      RootPageModel('组件', '/component', ComponentRootPage(),
          icon: Icons.token_outlined),
      RootPageModel('工具', '/util', UtilRootPage(), icon: Icons.grid_view),
      RootPageModel('模版', '/template', TemplateRootPage(),
          icon: Icons.temple_hindu),
      RootPageModel('我的', '/my', MyRootPage(), icon: Icons.person),
    ]),
  ],
);
