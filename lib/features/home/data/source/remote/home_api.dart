import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/home/data/dto/movies_response/movies_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api.g.dart';

final homeApiProvider = Provider<HomeApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return HomeApi(dio);
});

@RestApi()
abstract class HomeApi {
  factory HomeApi(Dio dio) => _HomeApi(dio);

  @GET(filmEndPoint)
  Future<MoviesResponse> getMovies(@Query("page") int page, @Query("pageSize") int pageSize);
}