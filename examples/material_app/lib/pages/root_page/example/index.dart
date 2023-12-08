import 'package:flutter/material.dart';

class ExampleRootPage extends StatefulWidget {
  const ExampleRootPage({super.key});

  @override
  State<ExampleRootPage> createState() => _ExampleRootPageState();
}

class _ExampleRootPageState extends State<ExampleRootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('示例列表'),
      ),
      body: Container(),
    );
  }
}
