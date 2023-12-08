import 'package:flutter/cupertino.dart';

class ChatRootPage extends StatefulWidget {
  const ChatRootPage({Key? key}) : super(key: key);

  @override
  State<ChatRootPage> createState() => _ChatRootPageState();
}

class _ChatRootPageState extends State<ChatRootPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: [
        const CupertinoSliverNavigationBar(largeTitle: Text('消息列表')),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context, rootNavigator: false).push(
                      CupertinoPageRoute(builder: (ctx) => const _ChildPage()));
                },
                child: const Text('子页面'),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () {
                  setState(() {
                    count++;
                  });
                },
                child: Text('count: $count'),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

class _ChildPage extends StatefulWidget {
  const _ChildPage();

  @override
  State<_ChildPage> createState() => _ChildPageState();
}

class _ChildPageState extends State<_ChildPage> {
  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('消息列表-子页面'),
        previousPageTitle: '消息列表',
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context, rootNavigator: false).push(
                    CupertinoPageRoute(builder: (ctx) => const _ChildPage()),
                  );
                },
                child: const Text('下一个子页面'),
              ),
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context, rootNavigator: false).push(
                    CupertinoPageRoute(
                      builder: (ctx) => const _ChildPage2(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: const Text('子页面2'),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context).push(
                      CupertinoPageRoute(builder: (ctx) => const _ThreePage()));
                },
                child: const Text('三级页面'),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChildPage2 extends StatelessWidget {
  const _ChildPage2();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('消息列表-子页面2'),
        previousPageTitle: '子页面1',
      ),
      child: SafeArea(
        child: Center(
          child: CupertinoButton.filled(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('返回'),
          ),
        ),
      ),
    );
  }
}

class _ThreePage extends StatelessWidget {
  const _ThreePage();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('三级页面'),
      ),
      child: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('返回首页'),
              ),
              const SizedBox(height: 8),
              CupertinoButton.filled(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('返回'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
