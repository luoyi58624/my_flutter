import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class ChildPage extends StatelessWidget {
  const ChildPage(
      {super.key, required this.title, this.previousPageTitle = '返回'});

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
          child: Center(
            child: CupertinoButton.filled(
              onPressed: () {
                RouterUtil.back(context);
              },
              child: const Text('返回'),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              RouterUtil.back(context);
            },
            child: const Text('返回'),
          ),
        ),
      );
    }
  }
}
