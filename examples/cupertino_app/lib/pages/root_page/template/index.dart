import 'package:flutter/cupertino.dart';

class TemplateRootPage extends StatefulWidget {
  const TemplateRootPage({super.key});

  @override
  State<TemplateRootPage> createState() => _TemplateRootPageState();
}

class _TemplateRootPageState extends State<TemplateRootPage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(largeTitle: Text('模版列表')),
        ],
      ),
    );
  }
}
