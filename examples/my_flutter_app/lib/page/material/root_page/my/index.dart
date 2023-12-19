import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class MyRootPage extends StatelessWidget {
  const MyRootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Chats'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(IconData(0xe660, fontFamily: 'iconfont')),
                  onPressed: () {},
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Icon(IconData(0xe66e, fontFamily: 'iconfont')),
                  onPressed: () {},
                ),
              ],
            ),
            border: null,
          ),
          SliverList.builder(
            itemCount: 100,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                RouterUtil.to(
                  context,
                  const ChildPage(title: '子页面'),
                  rootNavigator: true,
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
