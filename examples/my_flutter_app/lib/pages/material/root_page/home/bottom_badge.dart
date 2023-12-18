import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';

class BottomBadgePage extends StatefulWidget {
  const BottomBadgePage({super.key});

  @override
  State<BottomBadgePage> createState() => _BottomBadgePageState();
}

class _BottomBadgePageState extends State<BottomBadgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置底部badge'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() => Text(
                '首页badge: ${BottomNavigationController.of.badge.value['/']}')),
            ElevatedButton(
              onPressed: () {
                BottomNavigationController.of.addBadge('/', 1);
              },
              child: const Text('首页badge+1'),
            ),
            ElevatedButton(
              onPressed: () {
                BottomNavigationController.of.subtractBadge('/', 1);
              },
              child: const Text('首页badge-1'),
            ),
            ElevatedButton(
              onPressed: () {
                BottomNavigationController.of.setBadge('/', 10);
              },
              child: const Text('首页badge=10'),
            ),
            ElevatedButton(
              onPressed: () {
                BottomNavigationController.of.clearBadge('/');
              },
              child: const Text('清除badge'),
            ),
          ],
        ),
      ),
    );
  }
}
