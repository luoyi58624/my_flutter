import 'package:flutter/cupertino.dart';
import 'package:package/index.dart';

import 'call/index.dart';
import 'chat/index.dart';
import 'people/index.dart';
import 'setting/index.dart';

const _pages = [
  NavPageModel('聊 天', ChatRootPage(), icon: CupertinoIcons.chat_bubble_2),
  NavPageModel('通 话', CallRootPage(), icon: CupertinoIcons.phone),
  NavPageModel('联系人', PeopleRootPage(), icon: CupertinoIcons.person),
  NavPageModel('设 置', SettingRootPage(), icon: CupertinoIcons.settings),
];

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoRootPage(
      pages: _pages,
      // tabbarInactiveColor: CupertinoColors.inactiveGray,
    );
  }
}
