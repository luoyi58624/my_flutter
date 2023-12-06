import 'package:flutter/cupertino.dart';
import 'package:my_flutter/pages/cupertino.dart';
import 'cart/index.dart';
import 'chat/index.dart';
import 'classify/index.dart';
import 'home/index.dart';
import 'user/index.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoRootPage(
      pages: [
        RootPageModel('首页', CupertinoIcons.home, HomeRootPage()),
        RootPageModel('分类', CupertinoIcons.list_bullet, ClassifyRootPage()),
        RootPageModel('消息', CupertinoIcons.chat_bubble, ChatRootPage()),
        RootPageModel('购物车', CupertinoIcons.cart, CartRootPage()),
        RootPageModel('个人中心', CupertinoIcons.person, UserRootPage()),
      ],
    );
  }
}
