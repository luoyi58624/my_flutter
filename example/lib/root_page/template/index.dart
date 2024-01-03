import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class TemplateRootPage extends StatefulWidget {
  const TemplateRootPage({super.key});

  @override
  State<TemplateRootPage> createState() => TemplateRootPageState();
}

class TemplateRootPageState extends State<TemplateRootPage> {
  int count = 0;

  void addCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // LoggerUtil.i('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('模版列表'),
      ),
      body: buildCenterColumn([]),
    );
  }
}
