import 'package:flutter/material.dart';
import 'package:package/index.dart';

import 'apps/material/root_page/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initMyFlutter();
  runApp(const RestartAppWidget(child: _MyApp()));
}

class _MyApp extends StatelessWidget {
  const _MyApp();

  @override
  Widget build(BuildContext context) {
    return MyApp.material2(
      router: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomePage(),
            routes: [
              createRootPage(materialRootPages, 'material'),
              GoRoute(
                path: 'child',
                builder: (context, state) =>
                    const ExitInterceptWidget(child: ChildPage(title: '子页面')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    LoggerUtil.i('home build');
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
