import 'package:ani4h_app/features/login/domain/model/login_response.dart';

abstract interface class ILoginService {
  Future<LoginResponse> login(String email, String password);
}