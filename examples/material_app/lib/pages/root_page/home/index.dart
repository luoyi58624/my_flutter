import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'theme.dart';

class HomeRootPage extends StatefulWidget {
  const HomeRootPage({super.key});

  @override
  State<HomeRootPage> createState() => _HomeRootPageState();
}

class _HomeRootPageState extends State<HomeRootPage> {
  final List<ListTilePageModel> cellNames = const [
    ListTilePageModel('主题设置', ThemePage()),
  ];

  @override
  Widget build(BuildContext context) {
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
                  colorFilter: ColorFilter.mode(
                      Colors.grey.withOpacity(0.8), BlendMode.hardLight),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: cellNames
                  .map((e) => ListTile(
                        title: Text(e.title),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right_outlined),
                        onTap: () {
                          RouterUtil.to(e.widget);
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            elevation: 4,
            centerTitle: false,
            flexibleSpace: FlexibleSpaceBar(
              title: FlexibleTitleWidget(
                child: Text(
                  '首页',
                  style: Theme.of(context).appBarTheme.titleTextStyle,
                  strutStyle: Theme.of(context).useMaterial3
                      ? const StrutStyle(forceStrutHeight: true)
                      : null,
                ),
              ),
              background:
                  Image.asset("assets/images/home_bg.png", fit: BoxFit.fill),
              collapseMode: CollapseMode.pin,
            ),
            expandedHeight: 200,
            pinned: true,
            floating: false,
            snap: false,
            iconTheme: const IconThemeData(color: Colors.white),
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.menu),
            // ),
            // actions: <Widget>[
            //   IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.add),
            //   ),
            //   IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.more_horiz),
            //   ),
            // ],
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                RouterUtil.to(
                  ChildPage(title: '子页面：${index + 1}'),
                  noTransition: true,
                );
              },
              title: Text('列表 - ${index + 1}'),
            ),
          ),
        ],
      ),
    );
  }
}
