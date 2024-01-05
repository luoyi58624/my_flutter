import 'package:flutter/material.dart';

import '../../hive_model/index.dart';
import '../../plugins.dart';

class LocalStorageTestPage extends StatefulWidget {
  const LocalStorageTestPage({super.key});

  @override
  State<LocalStorageTestPage> createState() => _LocalStorageTestPageState();
}

class _LocalStorageTestPageState extends State<LocalStorageTestPage> {
  late LocalStorage<int> intStorage;
  late LocalStorage<Map<String, dynamic>?> mapStorage;
  late LocalStorage<UserModel> userModelStorage;
  int i = 0;

  @override
  void initState() {
    super.initState();
    CommonUtil.nextTick(() async {
      intStorage = await LocalStorage.init('int_storage');
      mapStorage = await LocalStorage.init<Map<String, dynamic>?>('map_storage');
      userModelStorage = await LocalStorage.init('user_model_storage');
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
          const Text('=========默认的lcoalStorage=========='),
          ElevatedButton(
            onPressed: () async {
              localStorage.setItem('name', 'luoyi');
            },
            child: const Text('插入String数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              String name = localStorage.getItem('name');
              LoggerUtil.i(name);
              ToastUtil.showToast(name.toString());
            },
            child: const Text('读取String数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              localStorage.setItem('count', 100);
            },
            child: const Text('插入int数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              int count = localStorage.getItem('count');
              LoggerUtil.i(count);
              ToastUtil.showToast(count.toString());
            },
            child: const Text('读取int数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              localStorage.setItem('map', {'username': 'luoyi', 'age': 20}, duration: 10000);
            },
            child: const Text('插入Map，10秒后过期'),
          ),
          ElevatedButton(
            onPressed: () async {
              Map? map = localStorage.getItem('map');
              LoggerUtil.i(map);
              ToastUtil.showToast(map.toString());
            },
            child: const Text('读取Map'),
          ),
          const Text('=========int类型的lcoalStorage=========='),
          ElevatedButton(
            onPressed: () async {
              i++;
              intStorage.setItem('count', i);
            },
            child: const Text('插入int'),
          ),
          ElevatedButton(
            onPressed: () async {
              int? count = intStorage.getItem('count');
              LoggerUtil.i(count);
              ToastUtil.showToast(count.toString());
            },
            child: const Text('读取int'),
          ),
          const Text('=========map类型的lcoalStorage=========='),
          ElevatedButton(
            onPressed: () async {
              mapStorage.setItem('map', {'username': 'luoyi', 'age': 20});
            },
            child: const Text('插入Map'),
          ),
          ElevatedButton(
            onPressed: () async {
              Map<String, dynamic>? map = mapStorage.getItem('map')?.cast<String, dynamic>();
              LoggerUtil.i(map);
              ToastUtil.showToast(map.toString());
            },
            child: const Text('获取Map数据'),
          ),
          const Text('=========UserModel对象类型的lcoalStorage=========='),
          ElevatedButton(
            onPressed: () async {
              userModelStorage.setItem('user_data', UserModel(username: 'luoyi', age: 20));
            },
            child: const Text('插入UserModel'),
          ),
          ElevatedButton(
            onPressed: () async {
              UserModel? userData = userModelStorage.getItem('user_data');
              LoggerUtil.i(userData);
              ToastUtil.showToast(userData.toString());
            },
            child: const Text('获取UserModel数据'),
          ),
          ElevatedButton(
            onPressed: () async {
              intStorage.clear();
              mapStorage.clear();
              userModelStorage.clear();
            },
            child: const Text('清空所有盒子数据'),
          ),
        ]),
      ),
    );
  }
}
