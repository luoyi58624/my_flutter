import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package/index.dart';

class MyRootPage extends StatelessWidget {
  const MyRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                RouterUtil.to(
                  const _SecondPage(title: '子页面'),
                );
              },
              title: Text('item-${index + 1}'),
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondPage extends StatelessWidget {
  const _SecondPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      child: Container(),
    );
  }
}
