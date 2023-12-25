import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package/index.dart';

class ChildPage extends StatelessWidget {
  const ChildPage({super.key, required this.title, this.previousPageTitle = '返回'});

  final String title;
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    var flag = CommonUtil.hasAncestorElements<CupertinoApp>(context);
    if (flag) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(title),
          previousPageTitle: previousPageTitle,
        ),
        child: SafeArea(
          child: buildCenterColumn([
            CupertinoButton.filled(
              onPressed: () {
                RouterUtil.to(ChildPage(title: title));
              },
              child: const Text('进入下一个子页面'),
            ),
            CupertinoButton.filled(
              onPressed: () {
                RouterUtil.back();
              },
              child: const Text('返回'),
            ),
          ]),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: buildCenterColumn([
          ElevatedButton(
            onPressed: () {
              RouterUtil.to(ChildPage(title: title));
            },
            child: const Text('进入下一个子页面'),
          ),
          ElevatedButton(
            onPressed: () {
              RouterUtil.back();
            },
            child: const Text('返回'),
          ),
        ]),
      );
    }
  }
}
