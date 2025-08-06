import 'package:contacts_app/feature/auth/presentation/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/presentation/pages/login_page.dart';
import '../../feature/auth/presentation/pages/sing_up_page.dart';
import '../../feature/auth/presentation/pages/welcome_page.dart';
import 'route_name.dart';
import 'routes.dart';

class AppRouter {
  final bool hasSeenWelcome;
  AppRouter(this.hasSeenWelcome);

  late final GoRouter router = GoRouter(
    initialLocation: RoutePaths.welcome,
    redirect: (context, state) async {
      final user = FirebaseAuth.instance.currentUser;
      final loggingInOrSigningUp = state.uri.path == RoutePaths.login ||
          state.uri.path == RoutePaths.singUp;

      // Get current welcome page state from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final currentHasSeenWelcome = prefs.getBool('hasSeenWelcome') ?? false;

      debugPrint('hasSeenWelcome: $hasSeenWelcome');
      debugPrint('currentHasSeenWelcome: $currentHasSeenWelcome');
      debugPrint('loggingInOrSigningUp: $loggingInOrSigningUp');
      debugPrint('user: $user');
      debugPrint('state.uri.path: ${state.uri.path}');

      // If user is not logged in and hasn't seen welcome page, show welcome
      if (user == null && !currentHasSeenWelcome) {
        return RoutePaths.welcome;
      }

      // If user is not logged in, has seen welcome, and not on auth pages, redirect to welcome
      if (user == null && currentHasSeenWelcome && !loggingInOrSigningUp) {
        return RoutePaths.welcome;
      }

      // If user is logged in and trying to access auth pages or welcome, redirect to contacts
      if (user != null &&
          (state.uri.path == RoutePaths.login ||
              state.uri.path == RoutePaths.singUp ||
              state.uri.path == RoutePaths.welcome)) {
        return RoutePaths.home;
      }

      return null;
    },
    
    routes: [
      GoRoute(
        name: RouteNames.welcome,
        path: RoutePaths.welcome,
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        name: RouteNames.singUp,
        path: RoutePaths.singUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        name: RouteNames.login,
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: RouteNames.home,
        path: RoutePaths.home,
        builder: (context, state) => const Home(),
      ),
    ],
  );
}
