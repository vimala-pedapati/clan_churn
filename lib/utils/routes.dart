import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const intial = "/";
  static const home = "/home";
  static const signIn = "/signIn";
  static const savedReports = "/savedReports";
  static const forgotPassword = "/forgotPassword";
  static const resetPassword = "/resetPassword";
  static const createClient = "/createClient";

 // Sub Routes
  static const generateMarts = "generateMarts";
  static const projects = "projects";
  static const editLabels = "editLabels";
  static const updateProject = "updateProject";
  static const createProject = "createProject";
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
