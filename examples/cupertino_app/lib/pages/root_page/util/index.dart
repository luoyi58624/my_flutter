import 'package:flutter/cupertino.dart';

class UtilRootPage extends StatefulWidget {
  const UtilRootPage({super.key});

  @override
  State<UtilRootPage> createState() => _UtilRootPageState();
}

class _UtilRootPageState extends State<UtilRootPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text('工具列表')),
        ],
      ),
    );
  }
}
