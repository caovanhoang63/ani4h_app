import 'package:ani4h_app/core/data/remote/token/itoken_service.dart';
import 'package:ani4h_app/core/data/remote/token/token_service.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/core/provider/auth_state_provider.dart';
import 'package:ani4h_app/core/route/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final logoutControllerProvider = Provider<LogoutController>((ref) {
  final tokenService = ref.watch(tokenServiceProvider(ref.read(networkServiceProvider)));
  final authState = ref.watch(authStateProvider.notifier);
  return LogoutController(tokenService, authState);
});

class LogoutController {
  final ITokenService _tokenService;
  final AuthState _authState;

  LogoutController(this._tokenService, this._authState);

  /// Logs out the user by:
  /// 1. Clearing tokens from secure storage
  /// 2. Setting auth state to false
  /// 3. Navigating to login screen
  Future<void> logout(GoRouter router) async {
    try {
      // Clear tokens from secure storage
      await _tokenService.clearToken();
      
      // Set auth state to false
      _authState.setAuthState(false);
      
      // Navigate to login screen
      router.go(introRoute);
    } catch (e) {
      print("Error during logout: $e");
      // Even if there's an error, try to navigate to login
      router.go(loginRoute);
    }
  }
}