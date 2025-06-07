import 'package:ani4h_app/common/http_status/status_code.dart';
import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/features/login/data/repository/ilogin_repository.dart';
import 'package:ani4h_app/features/login/domain/model/login_request.dart';
import 'package:ani4h_app/features/login/domain/model/login_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = Provider.family<ILoginRepository, Dio>((ref, dio) {
  return LoginRepository(dio);
});

class LoginRepository implements ILoginRepository {
  final Dio _dio;

  LoginRepository(this._dio);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "$authEndPoint/login",
        data: request.toJson(),
      );

      if (response.statusCode == success) {
        return LoginResponse.fromJson(response.data ?? {});
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: "Failed to login",
        );
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == unauthorized) {
        throw DioException(
          requestOptions: e.requestOptions,
          response: e.response,
          message: "Invalid credentials",
        );
      }
      rethrow;
    }
  }
}