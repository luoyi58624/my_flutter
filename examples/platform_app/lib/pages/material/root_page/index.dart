import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

final materialPages = [
  RootPageModel('首页', const HomeRootPage(), Icons.home),
  RootPageModel('分类', const ClassifyRootPage(), Icons.grid_view_rounded),
  RootPageModel('消息', const ChatRootPage(), CupertinoIcons.chat_bubble_fill),
  RootPageModel('购物车', const CartRootPage(), Icons.shopping_cart),
  RootPageModel('个人中心', const UserRootPage(), Icons.person_2_rounded),
];
