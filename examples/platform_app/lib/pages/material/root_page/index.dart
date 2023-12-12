import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

const materialPages = [
  RootPageModel('首页', HomeRootPage(), icon: Icons.home),
  RootPageModel('分类', ClassifyRootPage(), icon: Icons.grid_view_rounded),
  RootPageModel('消息', ChatRootPage(), icon: CupertinoIcons.chat_bubble_fill),
  RootPageModel('购物车', CartRootPage(), icon: Icons.shopping_cart),
  RootPageModel('个人中心', UserRootPage(), icon: Icons.person_2_rounded),
];
