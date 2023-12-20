import 'package:package/index.dart';

import 'page/material/root_page/index.dart';

final router = GoRouter(
  navigatorKey: globalNavigatorKey,
  routes: [
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => const RootPage(rootPages),
    // ),
    createRootPage(materialRootPages),
  ],
);
