import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

class ChildPage extends StatelessWidget {
  const ChildPage(
      {super.key, required this.title, this.previousPageTitle = '返回'});

  final String title;
  final String? previousPageTitle;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
        previousPageTitle: previousPageTitle,
      ),
      child: SafeArea(
          child: Center(
        child: CupertinoButton.filled(
          child: const Text('返回'),
          onPressed: () {
            RouterUtil.back(context: context);
          },
        ),
      )),
    );
  }
}
