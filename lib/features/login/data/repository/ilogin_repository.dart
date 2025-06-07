import 'package:ani4h_app/features/login/domain/model/login_request.dart';
import 'package:ani4h_app/features/login/domain/model/login_response.dart';

abstract interface class ILoginRepository {
  Future<LoginResponse> login(LoginRequest request);
}