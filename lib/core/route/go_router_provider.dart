import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/favorite/presentation/ui/favorite_screen.dart';
import 'package:ani4h_app/features/history/presentation/ui/history_screen.dart';
import 'package:ani4h_app/features/main/presentation/ui/main_screen.dart';
import 'package:ani4h_app/features/login/presentation/ui/login_screen.dart';
import 'package:ani4h_app/features/signup/presentation/ui/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/movie_detail/presentation/ui/movie_detail_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(initialLocation: mainRoute, routes: [
    GoRoute(
      path: loginRoute,
      name: loginRoute,
      builder: (context, state) => const LoginScreen()
    ),
    GoRoute(
      path: signupRoute,
      name: signupRoute,
      builder: (context, state) => const SignUpScreen()
    ),
    GoRoute(
      path: mainRoute,
      name: mainRoute,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
        path: movieDetailRoute,
        name: movieDetailRoute,
        builder: (context, state) => const MovieDetailScreen()
    ),
    GoRoute(
        path: favoriteRoute,
        name: favoriteRoute,
        builder: (context, state) => const FavoriteScreen()
    ),
    GoRoute(
        path: historyRoute,
        name: historyRoute,
        builder: (context, state) => const HistoryScreen()
    )
  ]);
});
