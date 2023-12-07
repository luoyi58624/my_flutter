import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

final cupertinoPages = [
  RootPageModel('首页', const HomeRootPage(), CupertinoIcons.home),
  RootPageModel('分类', const ClassifyRootPage(), CupertinoIcons.list_bullet),
  RootPageModel('消息', const ChatRootPage(), CupertinoIcons.chat_bubble),
  RootPageModel('购物车', const CartRootPage(), CupertinoIcons.cart),
  RootPageModel('个人中心', const UserRootPage(), CupertinoIcons.person),
];
