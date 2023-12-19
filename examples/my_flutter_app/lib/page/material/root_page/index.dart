import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'component/index.dart';
import 'home/index.dart';
import 'my/index.dart';
import 'template/index.dart';
import 'util/index.dart';

const materialRootPages = [
  RootPageModel('首页', '/', HomeRootPage(), icon: Icons.home),
  RootPageModel('组件', '/component', ComponentRootPage(),
      icon: Icons.token_outlined),
  RootPageModel('工具', '/util', UtilRootPage(), icon: Icons.grid_view),
  RootPageModel('模版', '/template', TemplateRootPage(),
      icon: Icons.temple_hindu),
  RootPageModel('我的', '/my', MyRootPage(), icon: Icons.person),
];
