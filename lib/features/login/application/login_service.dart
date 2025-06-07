import 'package:ani4h_app/core/data/local/secure_storage/secure_storage_const.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/core/data/remote/token/itoken_service.dart';
import 'package:ani4h_app/core/data/remote/token/token_service.dart';
import 'package:ani4h_app/core/provider/auth_state_provider.dart';
import 'package:ani4h_app/features/login/application/ilogin_service.dart';
import 'package:ani4h_app/features/login/data/repository/ilogin_repository.dart';
import 'package:ani4h_app/features/login/data/repository/login_repository.dart';
import 'package:ani4h_app/features/login/domain/model/login_request.dart';
import 'package:ani4h_app/features/login/domain/model/login_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginServiceProvider = Provider<ILoginService>((ref) {
  final dio = ref.watch(networkServiceProvider);
  final loginRepository = ref.watch(loginRepositoryProvider(dio));
  final tokenService = ref.watch(tokenServiceProvider(dio));
  final authState = ref.watch(authStateProvider.notifier);
  return LoginService(loginRepository, tokenService, authState);
});

class LoginService implements ILoginService {
  final ILoginRepository _loginRepository;
  final ITokenService _tokenService;
  final AuthState _authState;

  LoginService(this._loginRepository, this._tokenService, this._authState);

  @override
  Future<LoginResponse> login(String email, String password) async {
    print("Login service called with email: $email");
    final request = LoginRequest(email: email, password: password);

    print("Calling login API");
    final response = await _loginRepository.login(request);
    print("Login API call successful");

    print("Access token received: ${response.data.accessToken.isNotEmpty ? 'not empty' : 'empty'}");
    print("Refresh token received: ${response.data.refreshToken.isNotEmpty ? 'not empty' : 'empty'}");

    // Save tokens to secure storage
    print("Saving tokens to secure storage");
    await _tokenService.saveToken(
      response.data.accessToken,
      response.data.refreshToken,
    );

    // Update auth state
    print("Updating auth state to true");
    _authState.setAuthState(true);

    print("Login process completed successfully");
    return response;
  }
}
