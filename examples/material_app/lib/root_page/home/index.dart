import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package/index.dart';

import 'bottom_badge.dart';
import 'demo/page.dart';
import 'theme.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  @override
  Widget build(BuildContext context) {
    LoggerUtil.i('home build');
    const List<NavPageModel> cellNames = [
      NavPageModel('主题设置', ThemePage()),
      NavPageModel('底部Badge设置', BottomBadgePage()),
    ];
    return Scaffold(
      drawer: Drawer(
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                'luoyi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: const Text('https://www.luoyi.website'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatars.jpg'),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage('assets/images/home_bg.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.8), BlendMode.hardLight),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ...cellNames
                    .map((e) => ListTile(
                  title: Text(e.title),
                  trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                  onTap: () {
                    RouterUtil.to(e.page);
                  },
                ))
                    .toList(),
                ListTile(
                  title: const Text('关闭弹窗'),
                  trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 4,
            flexibleSpace: FlexibleSpaceBar(
              // title: FlexibleTitleWidget(
              //   child: Text(
              //     '首页',
              //     style: Theme.of(context).appBarTheme.titleTextStyle,
              //     strutStyle: Theme.of(context).useMaterial3
              //         ? const StrutStyle(forceStrutHeight: true)
              //         : null,
              //   ),
              // ),
              background: Image.asset("assets/images/home_bg.png", fit: BoxFit.fill),
              collapseMode: CollapseMode.pin,
            ),
            expandedHeight: 200,
            pinned: true,
            floating: false,
            snap: false,
            stretch: true,
            iconTheme: const IconThemeData(color: Colors.white),
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.menu),
            // ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              PopupMenuButton(
                elevation: 2,
                offset: const Offset(0, 50),
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    child: Text('MaterialApp'),
                  ),
                  const PopupMenuItem(
                    child: Text('CupertinoApp'),
                  ),
                  const PopupMenuItem(
                    child: Text('重启App                                                                                   '),
                  ),
                ],
              ),
            ],
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                // RouterUtil.to(const _ChildPage2());
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (context) => _ChildPage2(),
                ));
              },
              title: Text('列表 - ${index + 1}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChildPage2 extends StatelessWidget {
  const _ChildPage2();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('二级子页面'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                RouterUtil.to(const _ChildPage3());
              },
              child: const Text('三级子页面'),
            ),
            ElevatedButton(
              onPressed: () {
                // RouterUtil.back();
                Navigator.of(context).pop();
              },
              child: const Text('返回'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const DemoPage(
                          index: 1,
                        )));
                // RouterUtil.to(() => const DemoPage());
              },
              child: const Text('Demo页面'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChildPage3 extends StatelessWidget {
  const _ChildPage3();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('三级子页面'),
      ),
      body: buildCenterColumn([
        ElevatedButton(
          onPressed: () {
            RouterUtil.to(const _ChildPage4());
          },
          child: const Text('四级子页面'),
        ),
        ElevatedButton(
          onPressed: () {
            RouterUtil.back(backNum: 2);
          },
          child: const Text('返回首页'),
        ),
      ]),
    );
  }
}

class _ChildPage4 extends StatelessWidget {
  const _ChildPage4();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('四级子页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // context.p
            // RouterUtil.back(backNum: 2, context: context);
          },
          child: const Text('返回二级子页面'),
        ),
      ),
    );
  }
}
