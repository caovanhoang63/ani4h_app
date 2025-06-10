import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/favorite_add_request/favorite_add_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/is_favorite_response/is_favorite_response.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';
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

  @GET("$filmEndPoint/{id}")
  Future<MovieDetailResponse> getMovieDetail(@Path("id") String id);

  @GET("$favoriteEndPoint/is-favorite")
  Future<IsFavoriteResponse> isFavorite(@Query("userId") String id, @Query("filmId") String filmId);

  @POST("$favoriteEndPoint/add")
  Future<void> addToFavorite(@Body() FavoriteAddRequest request);

  @DELETE("$favoriteEndPoint/remove")
  Future<void> removeFromFavorite(
    @Query("userId") String userId,
    @Query("filmId") String filmId,
  );
}