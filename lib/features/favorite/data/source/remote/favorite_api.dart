import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/favorite/data/dto/favorite_response/favorite_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'favorite_api.g.dart';

final favoriteApiProvider = Provider<FavoriteApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return FavoriteApi(dio);
});

@RestApi()
abstract class FavoriteApi {
  factory FavoriteApi(Dio dio) => _FavoriteApi(dio);

  @GET("$favoriteEndPoint/list")
  Future<FavoriteResponse> getFavorites(
      @Query("userId") String userId,
      @Query("page") int page,
      @Query("pageSize") int pageSize,
  );

  @POST("$favoriteEndPoint/add")
  Future<void> addFavorite(
      @Body() Map<String, dynamic> body,
  );

  @DELETE("$favoriteEndPoint/remove")
  Future<void> deleteFavorite(
      @Query("userId") String userId,
      @Query("filmId") String filmId,
  );
}