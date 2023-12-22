import 'package:flutter/cupertino.dart';

class SettingRootPage extends StatefulWidget {
  const SettingRootPage({super.key});

  @override
  State<SettingRootPage> createState() => _SettingRootPageState();
}

class _SettingRootPageState extends State<SettingRootPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text('设置')),
        ],
      ),
    );
  }
}
