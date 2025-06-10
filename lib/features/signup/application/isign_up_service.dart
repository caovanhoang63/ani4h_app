
import 'package:ani4h_app/features/signup/data/dto/sign_up_request.dart';

import '../data/dto/sign_up_response.dart';

abstract interface class ISignUpService {
  Future<SignUpResponse> signUp(SignUpRequest request);
}