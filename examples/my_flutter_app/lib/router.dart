import 'package:my_flutter/my_flutter.dart';

import 'pages/material/root_page/index.dart';

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
