import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

const cupertinoPages = [
  RootPageModel('首页', HomeRootPage(), icon: CupertinoIcons.home),
  RootPageModel('分类', ClassifyRootPage(), icon: CupertinoIcons.list_bullet),
  RootPageModel('消息', ChatRootPage(), icon: CupertinoIcons.chat_bubble),
  RootPageModel('购物车', CartRootPage(), icon: CupertinoIcons.cart),
  RootPageModel('个人中心', UserRootPage(), icon: CupertinoIcons.person),
];
