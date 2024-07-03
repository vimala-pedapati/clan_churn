import 'package:clan_churn/api_repos/api_repo.dart';
import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/api_repos/models/user_model.dart';
import 'package:clan_churn/churn_blocs/project_architect/project_architect_bloc.dart';
import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/churn_blocs/user/user_bloc.dart';
import 'package:clan_churn/components/reports.dart';
import 'package:clan_churn/components/step_tracker.dart';
import 'package:clan_churn/pages/admin_home_page.dart';
import 'package:clan_churn/pages/create_client.dart';
import 'package:clan_churn/pages/forgot_password_screen.dart';
import 'package:clan_churn/pages/home_page.dart';
import 'package:clan_churn/pages/client_projects_view.dart';
import 'package:clan_churn/pages/reset_password_link.dart';
import 'package:clan_churn/pages/saved_projects.dart';
import 'package:clan_churn/pages/sign_page.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (kIsWeb) {
  //   HydratedBloc.storage = await HydratedStorage.build(
  //       storageDirectory: HydratedStorage.webStorageDirectory);
  // }
  // FlutterSecureStorage storage = const FlutterSecureStorage();
  AuthRepository authRepository = AuthRepository();
  ApiRepository apiRepository = ApiRepository();
  runApp(ClanChurnApp(
    authRepository: authRepository,
    apiRepository: apiRepository,
  ));
  // if (kIsWeb) {
  //   setUrlStrategy( PathUrlStrategy());
  // }
}

class ClanChurnApp extends StatelessWidget {
  const ClanChurnApp(
      {super.key, required this.authRepository, required this.apiRepository});
  final AuthRepository authRepository;
  final ApiRepository apiRepository;

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.intial,
          // builder: (BuildContext context, GoRouterState state) =>
          //     BlocBuilder<SignInBloc, SignInBlocState>(
          //       builder: (context, state) {
          //         return const ClanChurnSignInPage();
          //       },
          //     )
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: const ClanChurnSignInPage()),
        ),
        GoRoute(
          path: AppRoutes.signIn,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: const ClanChurnSignInPage()),
        ),
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return state.user?.userType == UserType.admin
                      ? const AdminHomePage()
                      : const HomePage();
                },
              )),
        ),

        // GoRoute(
        //   path: AppRoutes.savedProjects,
        //   pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
        //       context: context, state: state, child: const PerformanceReport()),
        // ),
        GoRoute(
          path: AppRoutes.savedProjects,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context, state: state, child: Container()),
        ),
        GoRoute(
          path: AppRoutes.createClient,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context, state: state, child: const CreateClient()),
        ),
        GoRoute(
          path: AppRoutes.clientProjects,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: const ClientProjectsView()),
        ),
        GoRoute(
          path: '/myApp',
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context, state: state, child: const MyApp()),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: const ForgotPasswordScreen()),
        ),
        GoRoute(
          path: AppRoutes.resetPassword,
          // pageBuilder: (context, state) {
          //   print("...............................");
          //   final String? token = state.uri.queryParameters['token'];
          //    print('matched location Parameters: ${state.uri.queryParameters}');
          //   return MaterialPage(child: ResetPasswordScreen(token));
          // },
          pageBuilder: (context, state) => customPageRouteForGoRouter<void>(
              context: context,
              state: state,
              child: ResetPasswordScreen(state.uri.queryParameters['token'])),
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
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          canvasColor: Colors.grey,
          textTheme: GoogleFonts.montserratTextTheme().copyWith(),
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(108, 63, 235, 1),
              primary: const Color.fromRGBO(108, 63, 235, 1),
              secondary: const Color.fromRGBO(56, 56, 56, 1),
              onSecondary: const Color.fromRGBO(125, 125, 125, 1),
              tertiary: const Color.fromRGBO(199, 199, 199, 1),
              background: const Color(0xffFFFFFF),
              shadow: const Color.fromRGBO(0, 0, 0, 0.15),
              onBackground: Colors.black),
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
