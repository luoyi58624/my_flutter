import 'package:flutter/cupertino.dart';

class ExampleRootPage extends StatefulWidget {
  const ExampleRootPage({super.key});

  @override
  State<ExampleRootPage> createState() => _ExampleRootPageState();
}

class _ExampleRootPageState extends State<ExampleRootPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text('示例列表')),
        ],
      ),
    );
  }
}
