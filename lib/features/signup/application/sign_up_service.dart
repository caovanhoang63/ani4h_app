import 'package:ani4h_app/features/signup/application/isign_up_service.dart';
import 'package:ani4h_app/features/signup/data/dto/sign_up_request.dart';
import 'package:ani4h_app/features/signup/data/dto/sign_up_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/data/remote/network_service.dart';
import '../data/repository/isign_up_repository.dart';
import '../data/repository/sign_up_repository.dart';


final signUpServiceProvider = Provider<ISignUpService>((ref) {
  final dio = ref.watch(networkServiceProvider);
  final signUpRepository = ref.watch(signUpRepositoryProvider(dio));

  return SignUpService(signUpRepository);
});


class SignUpService implements ISignUpService {
  final ISignUpRepository _repository;

  SignUpService(this._repository);

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) {
      final response = _repository.signUp(request);
      return response;
  }
}