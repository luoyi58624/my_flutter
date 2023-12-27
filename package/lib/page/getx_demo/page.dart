import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class GetxDemoPage extends StatefulWidget {
  const GetxDemoPage({super.key});

  @override
  State<GetxDemoPage> createState() => _GetxDemoPageState();
}

class _GetxDemoPageState extends State<GetxDemoPage> {
  final controller = Get.put(GetxDemoController());

  @override
  Widget build(BuildContext context) {
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
