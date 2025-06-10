import 'package:ani4h_app/features/plan/data/source/remote/subscription_api.dart';
import 'package:ani4h_app/features/signup/data/dto/sign_up_request.dart';
import 'package:ani4h_app/features/signup/data/dto/sign_up_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/exception/failure.dart';
import '../../../../common/http_status/status_code.dart';
import '../../../../common/mixin/dio_exception_mapper.dart';
import '../../../../core/data/remote/endpoint.dart';
import '../source/remote/sign_up_api.dart';
import 'isign_up_repository.dart';

/*final signUpRepositoryProvider = Provider<ISignUpRepository>((ref) {
  final signUpApi = ref.watch(signUpApiProvider);
  return SignUpRepository(signUpApi);
});*/
final signUpRepositoryProvider = Provider.family<ISignUpRepository, Dio>((ref, dio) {
  return SignUpRepository(dio);
});

final class SignUpRepository with DioExceptionMapper implements ISignUpRepository {
  final Dio _dio;

  SignUpRepository(this._dio);

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        "$authEndPoint/register",
        data: request.toJson(),
      );

      if (response.statusCode == success) {
        return SignUpResponse.fromJson(response.data ?? {});
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