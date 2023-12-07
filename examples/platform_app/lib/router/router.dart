import 'package:my_flutter/my_flutter.dart';

import '../pages/root_page.dart';

final routes = [
  GoRoute(path: '/', builder: (context, state) => const RootPage()),
  GoRoute(path: '/shop_search', builder: (context, state) => const RootPage()),
];
