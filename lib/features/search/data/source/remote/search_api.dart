import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_search_response/top_search_response.dart';
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

  @GET("$searchEndPoint/suggest")
  Future<SearchResultResponse> search(
      @Query("keyword") String query,
      @Query("page") int page,
      @Query("pageSize") int pageSize
  );

  @GET("$searchEndPoint/top-search")
  Future<TopSearchResponse> getTopSearch();
}