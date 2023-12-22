import 'dart:convert';

import 'package:desktop_multi_window/desktop_multi_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_ui/macos_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MacosApp(
      theme: MacosThemeData.dark(),
      darkTheme: MacosThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MacosWindow(
        sidebar: Sidebar(
          minWidth: 200,
          dragClosed: false,
          builder: (context, scrollController) {
            return SidebarItems(
              currentIndex: _pageIndex,
              onChanged: (index) {
                setState(() => _pageIndex = index);
              },
              items: const [
                SidebarItem(
                  leading: MacosIcon(CupertinoIcons.home),
                  label: Text('Home'),
                ),
                SidebarItem(
                  leading: MacosIcon(CupertinoIcons.search),
                  label: Text('Explore'),
                ),
              ],
            );
          },
        ),
        child: IndexedStack(
          index: _pageIndex,
          children: [
            Center(
              child: CupertinoButton.filled(
                  onPressed: () async {
                    final window = await DesktopMultiWindow.createWindow(jsonEncode({
                      'args1': 'Sub window',
                      'args2': 100,
                      'args3': true,
                      'bussiness': 'bussiness_test',
                    }));
                    window
                      ..setFrame(const Offset(0, 0) & const Size(1280, 720))
                      ..center()
                      ..setTitle('Another window')
                      ..show();
                  },
                  child: Text('首页')),
            ),
            const Center(
              child: Text('Demo页'),
            ),
          ],
        ));
  }
}
