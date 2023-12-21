import 'package:flutter/cupertino.dart';

class CallRootPage extends StatefulWidget {
  const CallRootPage({super.key});

  @override
  State<CallRootPage> createState() => _CallRootPageState();
}

class _CallRootPageState extends State<CallRootPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text('通话记录')),
        ],
      ),
    );
  }
}
