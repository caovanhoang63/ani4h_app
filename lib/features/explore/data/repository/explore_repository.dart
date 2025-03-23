import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/explore_response.dart';
import 'package:ani4h_app/features/explore/data/repository/iexplore_repository.dart';
import 'package:ani4h_app/features/explore/data/source/remote/explore_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exploreRepositoryProvider = Provider<IExploreRepository>((ref) {
  final exploreApi = ref.watch(exploreApiProvider);
  return ExploreRepository(exploreApi);
});

final class ExploreRepository with DioExpceptionMapper implements IExploreRepository {
  final ExploreApi _exploreApi;
  ExploreRepository(this._exploreApi);

  @override
  Future<ExploreResponse> getExplore(ExploreParams params, int page, int pageSize) async {
    try {
      final response = await _exploreApi.getExplore(params, page, pageSize);
      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: e as Exception,
        stackTrace: s,
      );
    }
  }
}