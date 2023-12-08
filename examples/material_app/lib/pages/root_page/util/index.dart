import 'package:flutter/material.dart';

class UtilRootPage extends StatefulWidget {
  const UtilRootPage({super.key});

  @override
  State<UtilRootPage> createState() => _UtilRootPageState();
}

class _UtilRootPageState extends State<UtilRootPage> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工具列表'),
      ),
      body: Scrollbar(
        controller: controller,
        child: ListView.builder(
          controller: controller,
          itemCount: 100,
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: Text('列表 - ${index + 1}'),
          ),
        ),
      ),
    );
  }
}
