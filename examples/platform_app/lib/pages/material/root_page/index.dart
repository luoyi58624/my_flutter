import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

const materialPages = [
  NavPageModel('首页', HomeRootPage(), icon: Icons.home),
  NavPageModel('分类', ClassifyRootPage(), icon: Icons.grid_view_rounded),
  NavPageModel('消息', ChatRootPage(), icon: CupertinoIcons.chat_bubble_fill),
  NavPageModel('购物车', CartRootPage(), icon: Icons.shopping_cart),
  NavPageModel('个人中心', UserRootPage(), icon: Icons.person_2_rounded),
];
