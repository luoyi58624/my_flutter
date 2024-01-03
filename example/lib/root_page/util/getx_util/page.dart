import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_sliver_list/super_sliver_list.dart';

import '../../../plugins.dart';
import 'controller.dart';

class GetxUtilPage extends StatelessWidget {
  const GetxUtilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetxUtilController());
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
        ElevatedButton(
          onPressed: () {
            RouterUtil.to(const _ListPage());
          },
          child: const Text('响应式缓存列表页面'),
        ),
        ElevatedButton(
          onPressed: () {
            RouterUtil.to(const _ListPage2());
          },
          child: const Text('普通列表页面'),
        ),
      ]),
    );
  }
}

class _ListPage extends StatefulWidget {
  const _ListPage();

  @override
  State<_ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<_ListPage> {
  final GetxUtilController controller = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('响应式缓存列表'),
        actions: [
          IconButton(
            onPressed: () {
              controller.userList.clear();
            },
            icon: const Icon(Icons.clear),
          ),
          IconButton(
            onPressed: () {
              int length = controller.userList.length;
              for (int i = length; i < length + 10000; i++) {
                controller.userList.add({
                  'userId': i + 1,
                  'username': faker.person.firstName(),
                });
              }
              // List<Map<String, dynamic>> userList = [];
              // for (int i = length; i < length + 500; i++) {
              //   userList.add({
              //     'userId': i + 1,
              //     'username': faker.person.firstName(),
              //   });
              // }
              // controller.userList.addAll(userList);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(() {
        LoggerUtil.i('list build');
        return CupertinoScrollbar(
          controller: scrollController,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SuperSliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                    onTap: () {},
                    title: Text('${controller.userList[index]['userId']} - ${controller.userList[index]['username']} '),
                  ),
                  childCount: controller.userList.length,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class _ListPage2 extends StatefulWidget {
  const _ListPage2();

  @override
  State<_ListPage2> createState() => _ListPage2State();
}

class _ListPage2State extends State<_ListPage2> {
  List<Map<String, dynamic>> userList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('列表2'),
        actions: [
          IconButton(
            onPressed: () {
              userList.clear();
              setState(() {});
            },
            icon: const Icon(Icons.clear),
          ),
          IconButton(
            onPressed: () {
              int length = userList.length;
              for (int i = length; i < length + 500; i++) {
                userList.add({
                  'userId': i + 1,
                  'username': faker.person.firstName(),
                });
              }
              setState(() {});
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CupertinoScrollbar(
        child: ListView.builder(
          itemCount: userList.length,
          shrinkWrap: true,
          cacheExtent: 9999999999999,
          itemBuilder: (context, index) => ListTile(
            onTap: () {},
            title: Text('${userList[index]['userId']} - ${userList[index]['username']} '),
          ),
        ),
      ),
    );
  }
}
