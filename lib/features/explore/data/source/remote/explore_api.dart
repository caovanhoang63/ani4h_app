import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/explore_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'explore_api.g.dart';

final exploreApiProvider = Provider<ExploreApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return ExploreApi(dio);
});

@RestApi()
abstract class ExploreApi {
  factory ExploreApi(Dio dio) => _ExploreApi(dio);

  @GET(exploreEndPoint)
  Future<ExploreResponse> getExplore(
      @Queries() ExploreParams filters,
      @Query("page") int page,
      @Query("pageSize") int pageSize
  );
}