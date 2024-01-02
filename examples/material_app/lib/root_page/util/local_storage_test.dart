import 'package:flutter/material.dart';
import 'package:material_app/global.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageTestPage extends StatefulWidget {
  const LocalStorageTestPage({super.key});

  @override
  State<LocalStorageTestPage> createState() => _LocalStorageTestPageState();
}

class _LocalStorageTestPageState extends State<LocalStorageTestPage> {
  late LocalStorage<int> intStorage;
  late LocalStorage<Map<String, dynamic>> mapStorage;
  int i = 0;

  @override
  void initState() {
    super.initState();
    CommonUtil.nextTick(() async {
      LoadingUtil.show('加载中');
      intStorage = await LocalStorage.init('int_storage');
      mapStorage = await LocalStorage.init('map_storage');
      await 1.delay();
      LoadingUtil.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('本地存储测试'),
        ),
        body: buildCenterColumn([
          ElevatedButton(
            onPressed: () async {
              localStorage.setItem('name', 'luoyi');
            },
            child: const Text('插入String数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              localStorage.setItem('count', 100);
            },
            child: const Text('插入int数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              String name = localStorage.getItem('name');
              LoggerUtil.i(name);
            },
            child: const Text('读取String数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              int count = localStorage.getItem('count');
              LoggerUtil.i(count);
            },
            child: const Text('读取int数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              i++;
              intStorage.setItem('count', i);
            },
            child: const Text('插入int'),
          ),
          ElevatedButton(
            onPressed: () async {
              mapStorage.setItem('map', {'username': 'luoyi', 'age': 20});
            },
            child: const Text('插入Map'),
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic>? map = mapStorage.getItem('map');
              LoggerUtil.i(map);
            },
            child: const Text('获取Map数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              intStorage.clear();
              mapStorage.clear();
            },
            child: const Text('清空所有盒子数据'),
          ),
        ]),
      ),
    );
  }
}
