import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_request/login_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_response/login_response.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/users_response/users_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'movie_detail_api.g.dart';

final movieDetailApiProvider = Provider<MovieDetailApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return MovieDetailApi(dio);
});

@RestApi()
abstract class MovieDetailApi {
  factory MovieDetailApi(Dio dio) => _MovieDetailApi(dio);

  @GET(userEndPoint)
  Future<UsersResponse> getUsers(@Query("page") int page, @Query("pageSize") int pageSize);

  @POST("$authEndPoint/login")
  Future<LoginResponse> login(@Body() LoginRequest request);
}