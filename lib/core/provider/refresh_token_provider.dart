import 'package:ani4h_app/core/data/remote/token/itoken_service.dart';
import 'package:ani4h_app/core/data/remote/token/token_service.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/core/provider/auth_state_provider.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Provider that checks if a refresh token exists and handles token refresh
final refreshTokenProvider = Provider<RefreshTokenChecker>((ref) {
  final tokenService = ref.watch(tokenServiceProvider(ref.read(networkServiceProvider)));
  final authState = ref.watch(authStateProvider.notifier);
  return RefreshTokenChecker(tokenService, authState);
});

/// Class that handles checking for refresh token and refreshing tokens
class RefreshTokenChecker {
  final ITokenService _tokenService;
  final AuthState _authState;

  RefreshTokenChecker(this._tokenService, this._authState);

  /// Checks if a refresh token exists in secure storage
  /// If it exists, refreshes the tokens and returns true
  /// If it doesn't exist, returns false
  Future<bool> hasRefreshToken() async {
    print("hasRefreshToken called");
    final refreshToken = await _tokenService.getRefreshToken();
    print("Retrieved refresh token: ${refreshToken != null ? 'not null' : 'null'}, ${refreshToken?.isNotEmpty == true ? 'not empty' : 'empty'}");
    return refreshToken != null && refreshToken.isNotEmpty;
  }

  /// Refreshes the tokens using the refresh token
  /// Returns true if successful, false otherwise
  Future<bool> refreshTokens() async {
    print("refreshTokens called");
    try {
      final refreshToken = await _tokenService.getRefreshToken();
      print("Retrieved refresh token for refresh: ${refreshToken != null ? 'not null' : 'null'}, ${refreshToken?.isNotEmpty == true ? 'not empty' : 'empty'}");

      if (refreshToken == null || refreshToken.isEmpty) {
        print("Refresh token is null or empty, returning false");
        return false;
      }

      print("Calling API to refresh token");
      try {
        final response = await _tokenService.refreshToken(refreshToken);
        print("Token refresh API call successful");

        print("Saving new tokens to secure storage");
        await _tokenService.saveToken(
          response.data.accessToken,
          response.data.refreshToken,
        );

        print("Updating auth state to true");
        _authState.setAuthState(true);

        print("Token refresh completed successfully");
        return true;
      } catch (apiError) {
        print("API error during token refresh: $apiError");
        throw apiError;
      }
    } catch (e,s) {
      print("Error during token refresh: $e");
      print("stack $s");
      // If refresh token is invalid or expired, clear tokens and return false
      print("Clearing tokens and setting auth state to false");
      await _tokenService.clearToken();
      _authState.setAuthState(false);
      return false;
    }
  }

  /// Checks if a refresh token exists and refreshes tokens if it does
  /// If successful, returns true
  /// If not, returns false
  /// 
  /// This method can be used in two ways:
  /// 1. With a router parameter: will redirect to login page if token check fails
  /// 2. Without a router parameter: will just return the result without redirection
  Future<bool> checkAndRefreshToken([GoRouter? router]) async {
    print("checkAndRefreshToken called");

    // First check if the user is already logged in according to auth state
    final isLoggedIn = _authState.state;
    print("Current auth state (isLoggedIn): $isLoggedIn");

    // If the user is already logged in, we can skip the token check
    if (isLoggedIn) {
      print("User is already logged in according to auth state, returning true");

      // Even if the user is logged in according to auth state,
      // let's verify that we still have a valid refresh token
      // This is a safety check to ensure the tokens haven't been cleared
      final hasToken = await hasRefreshToken();
      print("Verifying refresh token exists: $hasToken");

      if (!hasToken) {
        print("No refresh token found despite auth state being true. This is unexpected.");
        print("Setting auth state to false and redirecting to login");
        _authState.setAuthState(false);
        if (router != null) {
          router.go(loginRoute);
        }
        return false;
      }

      return true;
    }

    // Otherwise, check if we have a refresh token
    final hasToken = await hasRefreshToken();
    print("hasRefreshToken: $hasToken");

    if (hasToken) {
      final success = await refreshTokens();
      print("refreshTokens success: $success");
      if (success) {
        print("Token refresh successful, returning true");
        return true;
      }
    }

    // If no refresh token or refresh failed, redirect to login if router is provided
    if (router != null) {
      print("Redirecting to login page");
      router.go(loginRoute);
    }
    print("Returning false from checkAndRefreshToken");
    return false;
  }
}
