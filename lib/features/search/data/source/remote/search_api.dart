import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_hot_response/top_hot_response.dart';
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
}