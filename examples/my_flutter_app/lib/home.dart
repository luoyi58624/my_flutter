import 'package:flutter/material.dart';
import 'package:package/index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ExitInterceptWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('首页'),
        ),
        body: buildCenterColumn([
          ElevatedButton(
            onPressed: () {
              context.go('/child');
            },
            child: const Text('子页面'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/material/component');
            },
            child: const Text('Material App'),
          ),
        ]),
      ),
    );
  }
}
