import '../dto/sign_up_request.dart';
import '../dto/sign_up_response.dart';

abstract interface class ISignUpRepository {
  Future<SignUpResponse> signUp(SignUpRequest request);
}