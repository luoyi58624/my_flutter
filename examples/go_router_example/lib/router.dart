import 'package:go_router/go_router.dart';

import 'page/child.dart';
import 'page/home.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/child',
    builder: (context, state) => const ChildPage(),
  ),
]);
