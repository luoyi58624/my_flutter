import 'package:example/plugins.dart';
import 'package:flutter/cupertino.dart';

class TemaplteChildPage extends StatelessWidget {
  const TemaplteChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: ExtendedCupertinoNavigationBar(
        middle: Text(
          '子页面',
        ),
        previousPageTitle: '模板列表',
        // previousPageTitle: 'Back',
      ),
      child: Center(
        child: Text('hello'),
      )
    );
  }
}

class TemaplteChildPage2 extends StatelessWidget {
  const TemaplteChildPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(
            '子页面2',
          ),
          previousPageTitle: '模板列表',
        ),
        child: Center(
          child: Text('hello'),
        )
    );
  }
}

