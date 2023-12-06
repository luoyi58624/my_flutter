import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

const materialPages = [
  RootPageModel('首页', Icons.home, HomeRootPage()),
  RootPageModel('分类', Icons.grid_view_rounded, ClassifyRootPage()),
  RootPageModel('消息', CupertinoIcons.chat_bubble_fill, ChatRootPage()),
  RootPageModel('购物车', Icons.shopping_cart, CartRootPage()),
  RootPageModel('个人中心', Icons.person_2_rounded, UserRootPage()),
];
