import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子页面'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.push('/child');
              },
              child: const Text('进入下一个子页面'),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('返回'),
            ),
          ],
        ),
      ),
    );
  }
}
