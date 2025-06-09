import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/search/data/dto/content_based_response/content_based_response.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_hot_response/top_hot_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_favorite_response/user_favorite_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_history_response/user_history_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'search_api.g.dart';

final searchApiProvider = Provider<SearchApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return SearchApi(dio);
});

@RestApi()
abstract class SearchApi {
  factory SearchApi(Dio dio) => _SearchApi(dio);

  @GET(searchEndPoint)
  Future<SearchResultResponse> search(
      @Queries() Map<String, dynamic> queryParams,
      @Queries() Map<String, dynamic> pagingParams,
  );

  @GET("$filmEndPoint/top-hot")
  Future<TopHotResponse> getTopHot(
      @Query("page") int page,
      @Query("pageSize") int pageSize,
  );

  @GET("$searchEndPoint/user-favorite")
  Future<UserFavoriteResponse> getUserFavorite(
      @Query("userId") String? userId,
      @Query("seed") int seed,
      @Query("page") int page,
      @Query("pageSize") int pageSize,
  );

  @GET("$searchEndPoint/user-history")
  Future<UserHistoryResponse> getUserHistory(
      @Query("userId") String? userId,
      @Query("seed") int seed,
      @Query("page") int page,
      @Query("pageSize") int pageSize,
  );

  @GET("$searchEndPoint/content-based")
  Future<ContentBasedResponse> getContentBasedSuggestion(
      @Query("filmId") String filmId,
      @Query("seed") int seed,
      @Query("page") int page,
      @Query("pageSize") int pageSize,
      );
}