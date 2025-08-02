import 'package:contacts_app/core/router/route_name.dart';
import 'package:contacts_app/core/router/routes.dart';
import 'package:contacts_app/feature/auth/presentation/pages/login_page.dart';
import 'package:contacts_app/feature/auth/presentation/pages/sing_up_page.dart';
import 'package:contacts_app/feature/auth/presentation/pages/welcome_page.dart';
import 'package:contacts_app/feature/contacts/presentation/pages/contacts_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RoutePaths.welcome,
  routes: [
    GoRoute(
      name: RouteNames.welcome,
      path: RoutePaths.welcome,
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      name: RouteNames.singUp,
      path: RoutePaths.singUp,
      builder: (context, state) => const SingUpPage(),
    ),
    GoRoute(
      name: RouteNames.login,
      path: RoutePaths.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: RouteNames.contacts,
      path: RoutePaths.contacts,
      builder: (context, state) => const ContactsPage(),
    ),
  ],
);
