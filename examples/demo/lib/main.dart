import 'package:flutter/material.dart';
import 'package:my_flutter/my_flutter.dart';
import 'package:my_flutter/pages/platform/index.dart';

void main() async {
  await initMyFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyPlatformApp(
      home: PlatformRootPage(pages: const [
        RootPageModel('组件', HomePage(), icon: Icons.home),
        RootPageModel('模版', TestPage(), icon: Icons.grid_view),
      ]),
      materialTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('首页'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            PlatformListTile(onTap: () {}, title: Text('item - ${index + 1}')),
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('测试'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            PlatformListTile(onTap: () {}, title: Text('test - ${index + 1}')),
      ),
    );
  }
}
