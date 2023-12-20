import 'package:go_router/go_router.dart';

import 'page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'child1',
          builder: (context, state) => const Child1Page(),
        ),
        GoRoute(
          path: 'child2',
          builder: (context, state) => const Child2Page(),
        ),
      ],
    ),
  ],
);
