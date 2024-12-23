import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/client/client_bloc.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/step_tracker.dart';
import 'package:clan_churn/pages/admin_home_page.dart';
import 'package:clan_churn/pages/client_projects_view.dart';
import 'package:clan_churn/pages/create_client.dart';
import 'package:clan_churn/pages/forgot_password_screen.dart';
import 'package:clan_churn/pages/generate_marts.dart';
import 'package:clan_churn/pages/home_page.dart';
import 'package:clan_churn/pages/new_project_components.dart';
import 'package:clan_churn/pages/project_thresholds.dart';
import 'package:clan_churn/pages/reset_password_link.dart';
import 'package:clan_churn/pages/saved_projects.dart';
import 'package:clan_churn/pages/sign_page.dart';
import 'package:clan_churn/pages/upload_input_sheet.dart';
import 'package:clan_churn/pages/view_summary_report.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'pages/project_input_fields_sheet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  setUrlStrategy(PathUrlStrategy());
  AuthRepo authRepository = AuthRepo();
  ApiRepository apiRepository = ApiRepository();
  runApp(ClanChurnApp(
    authRepository: authRepository,
    apiRepository: apiRepository,
  ));
}

class ClanChurnApp extends StatelessWidget {
  const ClanChurnApp({super.key, required this.authRepository, required this.apiRepository});
  final AuthRepo authRepository;
  final ApiRepository apiRepository;

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: <GoRoute>[
        // Sign in
        GoRoute(
          path: AppRoutes.signIn,
          pageBuilder: (context, state) {
            return customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: FutureBuilder<AuthCred>(
                future: AuthRepo().getTokens(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error occurred'));
                  } else if (snapshot.hasData) {
                    final AuthCred authCred = snapshot.data!;
                    if (authCred.accessToken.isNotEmpty) {
                      // Navigate to the home page if the access token is not empty
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context.go(AppRoutes.client);
                      });
                      return const SizedBox(); // Return an empty widget as we're navigating
                    }
                    return const ClanChurnSignInPage();
                  } else {
                    return const Center(child: Text('No data'));
                  }
                },
              ),
            );
          },
        ),

        // Initial
        GoRoute(
          path: AppRoutes.intial,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(context: context, state: state, child: const ClanChurnSignInPage()),
        ),
        // Home....
        GoRoute(
          path: AppRoutes.client,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                return state.user?.userType == UserType.admin ? const AdminHomePage() : const HomePage();
              })),
          routes: [
            // Client projects
            GoRoute(
                path: ":clientName/:clientId",
                pageBuilder: (context, state) {
                  final String clientId = state.pathParameters["clientId"] as String;
                  return customPageRouteForGoRouter(context: context, state: state, child: ClientProjectsView(clientId: clientId));
                },
                routes: [
                  // Project
                  GoRoute(
                    path: ':projectName/:projectId',
                    pageBuilder: (context, state) {
                      final String projectId = state.pathParameters["projectId"] as String;
                      final String clientId = state.pathParameters["clientId"] as String;
                      // return customPageRouteForGoRouter(context: context, state: state, child: const SizedBox.shrink());
                      return customPageRouteForGoRouter(
                          context: context,
                          state: state,
                          child: ProjectInputFieldsPage(
                            projectId: projectId,
                            clientId: clientId,
                          ));
                    },
                    routes: [
                      // Project edit labels
                      GoRoute(
                        path: AppRoutes.editLabels,
                        pageBuilder: (context, state) {
                          final String projectId = state.pathParameters["projectId"] as String;
                          final String clientId = state.pathParameters["clientId"] as String;
                          return customPageRouteForGoRouter(
                            context: context,
                            state: state,
                            child: ProjectInputFieldsPage(
                              projectId: projectId,
                              clientId: clientId,
                            ),
                          );
                        },
                      ),
                      // Update project
                      GoRoute(
                        path: AppRoutes.updateProject,
                        pageBuilder: (context, state) {
                          final String projectId = state.pathParameters["projectId"] as String;
                          final String clientId = state.pathParameters["clientId"] as String;
                          return customPageRouteForGoRouter(
                            context: context,
                            state: state,
                            child: CreateNewProject(
                              projectId: projectId,
                              clientId: clientId,
                            ),
                          );
                        },
                      ),
                      // Project thresholds
                      GoRoute(
                        path: AppRoutes.projectThresholds,
                        pageBuilder: (context, state) {
                          final String projectId = state.pathParameters["projectId"] as String;
                          final String clientId = state.pathParameters["clientId"] as String;
                          return customPageRouteForGoRouter(
                            context: context,
                            state: state,
                            child: GetProjectThresholdsPage(
                              projectId: projectId,
                              clientId: clientId,
                            ),
                          );
                        },
                      ),
                      // Upload Input Sheet
                      GoRoute(
                        path: AppRoutes.uploadNewSheet,
                        pageBuilder: (context, state) {
                          final String projectId = state.pathParameters["projectId"] as String;
                          final String clientId = state.pathParameters["clientId"] as String;
                          return customPageRouteForGoRouter(
                            context: context,
                            state: state,
                            child: UploadInputSheetPage(
                              projectId: projectId,
                              clientId: clientId,
                            ),
                          );
                        },
                      ),
                      // Project Summary Report
                      GoRoute(
                        path: AppRoutes.projectSummaryReport,
                        pageBuilder: (context, state) {
                          final String projectId = state.pathParameters["projectId"] as String;
                          final String clientId = state.pathParameters["clientId"] as String;
                          return customPageRouteForGoRouter(
                            context: context,
                            state: state,
                            child: ProjectSummaryReportPage(
                              projectId: projectId,
                              clientId: clientId,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  // Create project
                  GoRoute(
                    path: AppRoutes.createProject,
                    pageBuilder: (context, state) {
                      final String clientId = state.pathParameters["clientId"] as String;
                      return customPageRouteForGoRouter(
                        context: context,
                        state: state,
                        child: CreateNewProject(
                          projectId: null,
                          clientId: clientId,
                        ),
                      );
                    },
                  ),
                ]),
            // Generate Marts
            GoRoute(
              path: '${AppRoutes.generateMarts}/:projectId',
              pageBuilder: (context, state) {
                final extraData = state.extra as Map<String, dynamic>?;
                if (extraData == null) {
                  Future.microtask(() {
                    context.replace(AppRoutes.client);
                  });
                  return customPageRouteForGoRouter(context: context, state: state, child: const SizedBox.shrink());
                }
                final String? id = state.pathParameters["projectId"];
                return customPageRouteForGoRouter(context: context, state: state, child: GenerateMarts(projectId: id ?? ""));
              },
            ),
          ],
        ),
        GoRoute(
          path: AppRoutes.savedReports,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(context: context, state: state, child: const SavedReports()),
        ),
        GoRoute(
          path: AppRoutes.createClient,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(context: context, state: state, child: const CreateClient()),
        ),
        GoRoute(
          path: '/myApp',
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(context: context, state: state, child: const MyApp()),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(context: context, state: state, child: const ForgotPasswordScreen()),
        ),
        GoRoute(
          path: AppRoutes.resetPassword,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(context: context, state: state, child: ResetPasswordScreen(state.uri.queryParameters['token'])),
        ),
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInBloc(authRepository: authRepository),
        ),
        BlocProvider(
          create: (_) => UserBloc(apiRepository: apiRepository),
        ),
        BlocProvider(
          create: (_) => ProjectArchitectBloc(apiRepository: apiRepository),
        ),
        BlocProvider(
          create: (_) => ClientBloc(apiRepository: apiRepository),
        ),
      ],
      child: MaterialApp.router(
        // routerConfig: router,
        theme: ThemeData(
          canvasColor: Colors.grey,
          textTheme: GoogleFonts.montserratTextTheme().copyWith(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(108, 63, 235, 1),
            primary: const Color(0xFF6C3FEB),
            secondary: const Color.fromRGBO(56, 56, 56, 1),
            onSecondary: const Color.fromRGBO(125, 125, 125, 1),
            tertiary: const Color.fromRGBO(199, 199, 199, 1),
            background: const Color.fromRGBO(255, 255, 255, 1),
            shadow: const Color.fromRGBO(0, 0, 0, 0.15),
            onBackground: Colors.black,
            error: const Color.fromRGBO(230, 36, 36, 1),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: const Color.fromRGBO(108, 63, 235, 1),
              foregroundColor: const Color(0xffFFFFFF),
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color.fromRGBO(108, 63, 235, 1),
            // color: Colors.red
          ),
          useMaterial3: true,
        ),
        builder: (context, child) => ResponsiveBreakpoints.builder(
          breakpoints: [
            const Breakpoint(start: 0, end: 450, name: MOBILE),
            const Breakpoint(start: 451, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1920, name: DESKTOP),
            const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
          ],
          child: child!,
        ),
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        routeInformationProvider: router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
