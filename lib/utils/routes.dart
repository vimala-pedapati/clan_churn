import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const intial = "/";
  static const clients = "/home/client";
  static const signIn = "/signIn";
  static const savedReports = "/savedReports";
  static const forgotPassword = "/forgotPassword";
  static const resetPassword = "/resetPassword";
  static const createClient = "/createClient";

  static const generateMarts = "generateMarts";
  static const clientProjects = "clientProjects";
 
}

CustomTransitionPage customPageRouteForGoRouter<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
  );
}

/// To remove the default navigation between two routes along with screen wrapper
PageRouteBuilder<dynamic> customPageRouteForNavigation(
  Widget page,
) {
  return PageRouteBuilder<dynamic>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child; // No animation, just return the child directly
    },
  );
}
