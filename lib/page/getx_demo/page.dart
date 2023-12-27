import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class GetxDemoPage extends StatelessWidget {
  const GetxDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetxDemoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getx测试'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            controller.count.value++;
          },
          child: Obx(() {
            return Text('count: ${controller.count.value}');
          }),
        ),
      ),
    );
  }
}
