import 'package:ani4h_app/core/route/route_name.dart';
import 'package:ani4h_app/features/favorite/presentation/ui/favorite_screen.dart';
import 'package:ani4h_app/features/history/presentation/ui/history_screen.dart';
import 'package:ani4h_app/features/main/presentation/ui/main_screen.dart';
import 'package:ani4h_app/features/login/presentation/ui/login_screen.dart';
import 'package:ani4h_app/features/profile/presentation/ui/account_screen.dart';
import 'package:ani4h_app/features/profile/presentation/ui/setting_screen.dart';
import 'package:ani4h_app/features/profile/presentation/ui/terms_of_service_screen.dart';
import 'package:ani4h_app/features/search/presentation/ui/search_screen.dart';
import 'package:ani4h_app/features/signup/presentation/ui/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/movie_detail/presentation/ui/movie_detail_screen.dart';
import '../data/remote/token/token_service.dart';
import '../provider/refresh_token_provider.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final refreshTokenChecker = ref.watch(refreshTokenProvider);

  return GoRouter(
    initialLocation: mainRoute,
    redirect: (context, state) async {
      print("GoRouter redirect called for path: ${state.matchedLocation}");

      if (state.matchedLocation == loginRoute || state.matchedLocation == signupRoute) {
        print("Skipping token check for login/signup route");
        return null;
      }

      // For all other routes, check if we have a refresh token
      // If not, redirect to login
      print("Checking for valid token...");
      final hasValidToken = await refreshTokenChecker.checkAndRefreshToken(null);
      print("Token check result: $hasValidToken");

      if (!hasValidToken) {
        print("No valid token, redirecting to login page");
        return loginRoute;
      }

      print("Valid token found, allowing navigation to: ${state.matchedLocation}");
      return null;
    },
    routes: [
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
      routes: [
        GoRoute(
          path: settingRoute,
          name: settingRoute,
          builder: (context, state) => const SettingScreen(),
          routes: [
            GoRoute(
              path: accountRoute,
              name: accountRoute,
              builder: (context,state) => const AccountScreen(),
            ),
            GoRoute(
              path: termsOfServiceRoute,
              name: termsOfServiceRoute,
              builder: (context,state) => const TermsOfServiceScreen(),
            ),
          ]
        ),
      ]
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
    ),
    GoRoute(
        path: searchRoute,
        name: searchRoute,
        builder: (context, state) => const SearchScreen()
    ),
  ]);
});
