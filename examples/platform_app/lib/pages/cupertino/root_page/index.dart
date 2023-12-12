import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

const cupertinoPages = [
  NavPageModel('首页', HomeRootPage(), icon: CupertinoIcons.home),
  NavPageModel('分类', ClassifyRootPage(), icon: CupertinoIcons.list_bullet),
  NavPageModel('消息', ChatRootPage(), icon: CupertinoIcons.chat_bubble),
  NavPageModel('购物车', CartRootPage(), icon: CupertinoIcons.cart),
  NavPageModel('个人中心', UserRootPage(), icon: CupertinoIcons.person),
];
