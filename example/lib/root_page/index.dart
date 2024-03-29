import 'package:flutter/material.dart';

import '../plugins.dart';
import 'component/index.dart';
import 'home/index.dart';
import 'template/index.dart';
import 'util/index.dart';

const rootPages = [
  RootPageModel('首页', '/', HomeRootPage(), icon: Icons.home),
  RootPageModel('组件', '/component', ComponentRootPage(), icon: Icons.token_outlined),
  RootPageModel('工具', '/util', UtilRootPage(), icon: Icons.grid_view),
  RootPageModel('模版', '/template', TemplateRootPage(), icon: Icons.temple_hindu),
];
