import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter/my_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    LoggerUtil.i('xx');
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.push('/child');
          },
          child: const Text('子页面'),
        ),
      ),
    );
  }
}
