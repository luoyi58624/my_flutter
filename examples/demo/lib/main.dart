import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package/index.dart';

void main() async {
  await initMyFlutter();
  runApp(const _MyApp());
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MyApp.router(
      router: GoRouter(
        navigatorKey: globalNavigatorKey,
        routes: [
          GoRoute(path: '/', builder: (context, state) => HomePage()),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExitInterceptWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('首页'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(
                    builder: (context) => const ChildPage(),
                  ));
                },
                child: const Text('子页面'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(
                    builder: (context) => const CupertinoChildPage(),
                  ));
                },
                child: const Text('cupertino子页面'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChildPage extends StatelessWidget {
  const ChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('子页面'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            RouterUtil.to(const CupertinoChildPage());
            // Navigator.of(
            //   context,
            // ).push(MaterialPageRoute(
            //   builder: (context) => const CupertinoChildPage(),
            // ));
          },
          child: const Text('cupertino子页面'),
        ),
      ),
    );
  }
}

class CupertinoChildPage extends StatelessWidget {
  const CupertinoChildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('子页面'),
      ),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            RouterUtil.to(const ChildPage());
            // Navigator.of(
            //   context,
            // ).push(MaterialPageRoute(
            //   builder: (context) => const ChildPage(),
            // ));
          },
          child: const Text('子页面'),
        ),
      ),
    );
  }
}
