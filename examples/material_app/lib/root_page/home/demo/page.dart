import 'package:flutter/material.dart';
import 'package:package/index.dart';

import 'controller.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late final controller = Get.put(DemoController(), tag: widget.index.toString());

  @override
  void dispose() {
    super.dispose();
    Get.delete<DemoController>(tag: widget.index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo-${widget.index}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                RouterUtil.to(DemoPage(index: widget.index + 1));
              },
              child: Text('进入Demo${widget.index + 1}页面'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('返回'),
            ),
            FilledButton(
              onPressed: () {
                controller.count.value++;
              },
              child: Obx(() => Text('count: ${controller.count.value}')),
            ),
          ],
        ),
      ),
    );
  }
}
