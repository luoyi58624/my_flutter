import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

import 'controller.dart';

class GetxUtilPage extends StatelessWidget {
  GetxUtilPage({super.key});

  final controller = Get.put(GetxUtilController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getx工具类测试'),
      ),
      body: buildCenterColumn([
        Obx(
          () => ElevatedButton(
            onPressed: () {
              controller.count.value++;
            },
            child: Text('count: ${controller.count.value}'),
          ),
        ),
        Obx(
          () => ElevatedButton(
            onPressed: () {
              controller.userModel.value = UserModel.fromJson({
                'username': faker.person.firstName(),
                'password': Random().nextInt(100000),
              });
            },
            child: Text(controller.userModel.value.toString()),
          ),
        ),
      ]),
    );
  }
}
