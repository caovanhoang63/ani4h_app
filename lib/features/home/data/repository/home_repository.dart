import 'package:ani4h_app/features/home/data/repository/ihome_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../common/exception/failure.dart';
import '../dto/movies_response/movies_response.dart';
import '../source/remote/home_api.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';

final homeRepositoryProvider = Provider<IHomeRepository>((ref) {
  final homeApi = ref.watch(homeApiProvider);
  return HomeRepository(homeApi);
});

final class HomeRepository with DioExceptionMapper implements IHomeRepository {
  final HomeApi _homeApi;

  HomeRepository(this._homeApi);

  @override
  Future<MoviesResponse> getMovies(int page, int pageSize) async {
    try {
      final response = await _homeApi.getMovies(page, pageSize);

      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: toException(e),
        stackTrace: s,
      );
    }
  }
}