import 'package:flutter/cupertino.dart';
import 'package:package/index.dart';

import './pages/call/index.dart';
import './pages/chat/index.dart';
import './pages/people/index.dart';
import './pages/setting/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter(themeModel: const ThemeModel(primaryColor: CupertinoColors.systemGreen, textBold: true));
  runApp(MyApp.cupertino(
    router: GoRouter(
      routes: [
        createRootPage(const [
          RootPageModel('聊 天', '/', ChatRootPage(), icon: CupertinoIcons.chat_bubble_2),
          RootPageModel('通 话', '/call', CallRootPage(), icon: CupertinoIcons.phone),
          RootPageModel('联系人', '/people', PeopleRootPage(), icon: CupertinoIcons.person),
          RootPageModel('设 置', '/setting', SettingRootPage(), icon: CupertinoIcons.settings),
        ]),
      ],
    ),
  ));
}
