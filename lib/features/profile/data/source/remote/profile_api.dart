import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/profile/data/dto/profile_response.dart';
import 'package:ani4h_app/features/profile/data/dto/profile_simple_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api.g.dart';

final profileApiProvider = Provider<ProfileApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return ProfileApi(dio);
});

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio) => _ProfileApi(dio);

  @GET("$userEndPoint/{id}")
  Future<ProfileResponse> getProfile(@Path("id") String id);

  @GET("$userEndPoint/get-by-email")
  Future<ProfileSimpleResponse> getUserIdByEmail(@Query("email") String email);

}