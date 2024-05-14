import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const intial = "/";
  static const home = "/home";
  static const signIn = "/signIn";
  static const savedProjects = "/savedProjects";
  static const clientProjects = "/clientProjects";
}

CustomTransitionPage CustomRoute<T>({
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
