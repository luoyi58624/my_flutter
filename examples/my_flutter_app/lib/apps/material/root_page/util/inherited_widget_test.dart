import 'package:flutter/material.dart';
import 'package:package/index.dart';
import 'package:provider/provider.dart';

/// 用于向子组件共享的表单数据
class MyInheritedWidget extends InheritedWidget {
  const MyInheritedWidget({
    super.key,
    required super.child,
    required this.count,
    required this.increment,
  });

  final int count;
  final void Function() increment;

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.count != count;
  }
}

class InheritedWidgetTestPage extends StatefulWidget {
  const InheritedWidgetTestPage({super.key});

  @override
  State<InheritedWidgetTestPage> createState() =>
      _InheritedWidgetTestPageState();
}

class _InheritedWidgetTestPageState extends State<InheritedWidgetTestPage> {
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InheritedWidget测试'),
      ),
      body: Provider(
        create: (context) => LabelModel('InheritedWidgetTestPage', 'xxxx'),
        child: MyInheritedWidget(
          count: count,
          increment: increment,
          child: Center(
            child: Column(
              children: [
                Consumer<LabelModel>(
                  builder: (context, vable, child) => Text(vable.label),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      count++;
                    });
                  },
                  child: Text('count: $count'),
                ),
                ElevatedButton(
                  onPressed: () {
                    RouterUtil.to(context, const _ChildPage());
                  },
                  child: const Text('进入下一个InheritedWidget页面'),
                ),
                const _ChildWidget(),
                const _ProviderWidget(),
                Provider(
                  create: (context) => LabelModel('child', 'xxx'),
                  child: const _ProviderWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChildWidget extends StatelessWidget {
  const _ChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        MyInheritedWidget.of(context)?.increment();
      },
      child: Text('上一个页面的count: ${MyInheritedWidget.of(context)?.count}'),
    );
  }
}

class _ProviderWidget extends StatelessWidget {
  const _ProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LabelModel>(
      builder: (context, vable, child) => Text(vable.label),
    );
  }
}

class _ChildPage extends StatelessWidget {
  const _ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子页面'),
      ),
      body: Center(
        child: Column(
          children: [
            Consumer<LabelModel>(
              builder: (context, vable, child) => Text(vable.label),
            ),
            ElevatedButton(
              onPressed: () {},
              child:
                  Text('上一个页面的count: ${MyInheritedWidget.of(context)?.count}'),
            ),
          ],
        ),
      ),
    );
  }
}
