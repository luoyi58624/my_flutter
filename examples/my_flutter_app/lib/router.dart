import 'package:package/index.dart';

import 'apps/material/root_page/index.dart';
import 'home.dart';

final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        createRootPage(materialRootPages, 'material'),
        GoRoute(
          path: 'child',
          builder: (context, state) => const ChildPage(title: '子页面'),
        ),
      ],
    ),
  ],
);
