import 'package:flutter/widgets.dart';
import 'package:my_flutter/my_flutter.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

GoRouterPageBuilder routerPageBuilder<T>(Widget child) => (context, state) {
      return NoTransitionPage<T>(
        child: child,
      );
    };

ShellRoutePageBuilder shellRouterPageBuilder<T>(Widget child) =>
    (context, state, child) {
      return NoTransitionPage<T>(
        child: child,
      );
    };
