
import 'package:ani4h_app/features/signup/data/dto/sign_up_request.dart';
import 'package:ani4h_app/features/signup/data/dto/sign_up_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/data/remote/network_service.dart';

import '../../../../../core/data/remote/endpoint.dart';
part 'sign_up_api.g.dart';

final signUpApiProvider = Provider<SignUpApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return SignUpApi(dio);
});

@RestApi()
abstract class SignUpApi {
  factory SignUpApi(Dio dio) => _SignUpApi(dio);

  @POST("$authEndPoint/register")
  Future<SignUpResponse> signUp(@Body() String email, String password, String firstName, String lastName, String role, String dateOfBirth);

}