import 'package:flutter/material.dart';

class TemplateRootPage extends StatefulWidget {
  const TemplateRootPage({super.key});

  @override
  State<TemplateRootPage> createState() => _TemplateRootPageState();
}

class _TemplateRootPageState extends State<TemplateRootPage> {
  @override
  Widget build(BuildContext context) {
    // LoggerUtil.i('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('模版列表'),
      ),
      body: const Center(),
    );
  }
}
