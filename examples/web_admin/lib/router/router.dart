import 'package:flutter/cupertino.dart';
import 'package:flutter_admin/layout/layout.dart';
import 'package:flutter_admin/pages/home.dart';
import 'package:flutter_admin/pages/login.dart';
import 'package:flutter_admin/pages/menu.dart';
import 'package:flutter_admin/pages/system.dart';
import 'package:flutter_admin/pages/user.dart';
import 'package:flutter_admin/router/controller.dart';
import 'package:my_flutter/my_flutter.dart';

import 'utils.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final layoutNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  redirect: (BuildContext context, GoRouterState state) {
    RouterController.of.activePath.value = state.fullPath ?? '/';
    if (SpUtil.getBool('auth', defValue: false) == true) {
      return state.fullPath;
    } else {
      return '/login';
    }
  },
  routes: [
    GoRoute(
      path: '/login',
      parentNavigatorKey: rootNavigatorKey,
      pageBuilder: routerPageBuilder(const LoginPage()),
    ),
    StatefulShellRoute.indexedStack(
      // navigatorKey: layoutNavigatorKey,
      // pageBuilder: (context, state, child) => NoTransitionPage(
      //   child: LayoutPage(child: child),
      // ),
      builder: (context, state, navigationShell) =>
          LayoutPage(navigationShell: navigationShell),
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
