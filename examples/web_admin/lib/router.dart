import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:my_flutter/my_flutter.dart';

import 'layout/layout.dart';
import 'page/home.dart';
import 'page/login.dart';
import 'page/menu.dart';
import 'page/system.dart';
import 'page/user.dart';

final router = GoRouter(
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    // RouterController.of.activePath.value = state.fullPath ?? '/';
    if (localStorage.getItem('auth', false) == true) {
      return state.fullPath;
    } else {
      return '/login';
    }
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => LayoutPage(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/user',
              builder: (context, state) => const UserPage(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const AddUserPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/menu',
              builder: (context, state) => const MenuPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/system',
              builder: (context, state) => const SystemPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
