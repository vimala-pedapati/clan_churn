import 'package:clan_churn/api_repos/auth_repo.dart';
import 'package:clan_churn/churn_blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:clan_churn/pages/home_page.dart';
import 'package:clan_churn/pages/sign_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:clan_churn/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: HydratedStorage.webStorageDirectory);
  }
  FlutterSecureStorage storage = const FlutterSecureStorage();
  AuthRepository authRepository = AuthRepository();
  runApp(ClanChurnApp(
    authRepository: authRepository,
  ));
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }
}

class ClanChurnApp extends StatelessWidget {
  const ClanChurnApp({super.key, required this.authRepository});
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) =>
                BlocBuilder<SignInBloc, SignInBlocState>(
                  builder: (context, state) {
                    if (state.status == AuthenticationStatus.authenticated) {
                      return const HomePage();
                    }
                    return const ClanChurnSignInPage();
                  },
                )),
        GoRoute(
            path: '/signIn',
            builder: (BuildContext context, GoRouterState state) =>
                const ClanChurnSignInPage()),
        GoRoute(
            path: '/home',
            builder: (BuildContext context, GoRouterState state) =>
                const HomePage()),
      ],
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SignInBloc(authRepository: authRepository),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme().copyWith(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(108, 63, 235, 1),
            primary: const Color.fromRGBO(108, 63, 235, 1),
            secondary: const Color.fromRGBO(56, 56, 56, 1),
            onSecondary: const Color.fromRGBO(125, 125, 125, 1),
            background: const Color(0xffFFFFFF),
            shadow: const Color.fromRGBO(0, 0, 0, 0.15),
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
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        routeInformationProvider: _router.routeInformationProvider,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
