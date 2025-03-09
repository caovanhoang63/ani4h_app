import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/home/presentation/ui/home_screen.dart';
import 'package:ani4h_app/features/login/presentation/ui/login_screen.dart';
import 'package:ani4h_app/features/signup/presentation/ui/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: homeRoute, routes: [
    GoRoute(
        path: loginRoute,
        name: loginRoute,
        builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: signupRoute,
        name: signupRoute,
        builder: (context, state) => const SignUpScreen()),
    GoRoute(
        path: homeRoute,
        name: homeRoute,
        builder: (context, state) => const HomeScreen())
  ]);
});
