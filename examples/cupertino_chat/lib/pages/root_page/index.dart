import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/cupertino/index.dart';

import 'call/index.dart';
import 'chat/index.dart';
import 'people/index.dart';
import 'setting/index.dart';

const _pages = [
  NavPageModel('Chats', ChatRootPage(),
      icon: CupertinoIcons.chat_bubble_2_fill),
  NavPageModel('Calls', CallRootPage(), icon: CupertinoIcons.phone),
  NavPageModel('People', PeopleRootPage(),
      icon: CupertinoIcons.person_alt_circle),
  NavPageModel('Setting', SettingRootPage(),
      icon: CupertinoIcons.settings_solid),
];

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoRootPage(
      pages: _pages,
      tabbarInactiveColor: CupertinoColors.inactiveGray,
    );
  }
}
