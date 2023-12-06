import 'package:flutter/cupertino.dart';
import 'package:my_flutter/my_flutter.dart';

import '../../public_page/child.dart';

class ClassifyRootPage extends StatefulWidget {
  const ClassifyRootPage({Key? key}) : super(key: key);

  @override
  State<ClassifyRootPage> createState() => _ClassifyRootPageState();
}

class _ClassifyRootPageState extends State<ClassifyRootPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('分类'),
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) => CupertinoListTile(
              onTap: () {
                RouterUtil.push(
                    context, ChildPage(title: '列表详情页 - ${index + 1}'));
              },
              title: Text('${index + 1}.列表'),
            ),
          ),
        ),
      ),
    );
  }
}
