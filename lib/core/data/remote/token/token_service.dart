import 'package:ani4h_app/common/dtos/refresh_token_response.dart';
import 'package:ani4h_app/common/http_status/status_code.dart';
import 'package:ani4h_app/core/data/remote/token/itoken_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../local/secure_storage/isecure_storage.dart';
import '../../local/secure_storage/secure_storage.dart';
import '../../local/secure_storage/secure_storage_const.dart';

final tokenServiceProvider = Provider.family<ITokenService, Dio>((ref, dio) {
  final secureStorage = ref.watch(secureStorageProvider);
  return TokenService(dio, secureStorage);
});

class TokenService implements ITokenService {
  final Dio _dio;
  final ISecureStorage _secureStorage;

  TokenService(this._dio, this._secureStorage);

  @override
  Future<void> clearToken() {
    print("TokenService: Clearing tokens from secure storage");
    return Future.wait([
      _secureStorage.delete(accessTokenKey),
      _secureStorage.delete(refreshTokenKey),
    ]);
  }

  @override
  Future<String?> getAccessToken() async {
    print("TokenService: Getting access token from secure storage");
    final token = await _secureStorage.read(accessTokenKey);
    print("TokenService: Access token retrieved: ${token != null ? 'not null' : 'null'}, ${token?.isNotEmpty == true ? 'not empty' : 'empty'}");
    return token;
  }

  @override
  Future<String?> getRefreshToken() async {
    print("TokenService: Getting refresh token from secure storage");
    final token = await _secureStorage.read(refreshTokenKey);
    print("TokenService: Refresh token retrieved: ${token != null ? 'not null' : 'null'}, ${token?.isNotEmpty == true ? 'not empty' : 'empty'}");
    return token;
  }

  @override
  Future<RefreshTokenResponse> refreshToken(String? refreshToken) async {
    print("TokenService: Calling refresh token API with token: ${refreshToken != null ? 'not null' : 'null'}, ${refreshToken?.isNotEmpty == true ? 'not empty' : 'empty'}");

    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "/v1/auth/refresh",
        data: {
          "refreshToken": refreshToken,
        },
      );

      print("TokenService: Refresh token API response status: ${response.statusCode}");

      if (response.statusCode == success) {
        print("TokenService: Refresh token API call successful");
        print(response.data);
        final parsedResponse = RefreshTokenResponse.fromJson(response.data ?? {});
        print("TokenService: New access token: ${parsedResponse.data.accessToken.isNotEmpty ? 'not empty' : 'empty'}");
        print("TokenService: New refresh token: ${parsedResponse.data.refreshToken.isNotEmpty ? 'not empty' : 'empty'}");
        return parsedResponse;
      } else {
        print("TokenService: Refresh token API call failed with status: ${response.statusCode}");
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } catch (e) {
      print("TokenService: Error during refresh token API call: $e");
      rethrow;
    }
  }

  @override
  Future<void> saveToken(String accessToken, String refreshToken) {
    print("TokenService: Saving tokens to secure storage");
    print("TokenService: Access token to save: ${accessToken.isNotEmpty ? 'not empty' : 'empty'}");
    print("TokenService: Refresh token to save: ${refreshToken.isNotEmpty ? 'not empty' : 'empty'}");

    return Future.wait([
      _secureStorage.write(accessTokenKey, accessToken),
      _secureStorage.write(refreshTokenKey, refreshToken),
    ]);
  }

}
