import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import '../home/theme.dart';

class UtilRootPage extends StatefulWidget {
  const UtilRootPage({super.key});

  @override
  State<UtilRootPage> createState() => _UtilRootPageState();
}

class _UtilRootPageState extends State<UtilRootPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    LoggerUtil.i('util build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('工具列表'),
      ),
      drawer: Drawer(
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('子页面'),
                  trailing: const Icon(Icons.keyboard_arrow_right_outlined),
                  onTap: () {
                    RouterUtil.to(
                        context,
                        const ChildPage(
                          title: '子页面',
                        ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Scrollbar(
        controller: controller,
        child: ListView.builder(
          controller: controller,
          itemCount: 100,
          itemBuilder: (context, index) => ListTile(
            onTap: () {
              RouterUtil.to(context, const ThemePage());
            },
            title: Text('列表 - ${index + 1}'),
          ),
        ),
      ),
    );
  }
}
