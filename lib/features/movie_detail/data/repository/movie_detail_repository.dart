import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dto/movie_response/movie_response.dart';
import '../dto/movies_response/movies_response.dart';
import '../source/remote/movie_detail_api.dart';
import 'imovie_detail_repository.dart';

final movieDetailRepositoryProvider = Provider<IMovieDetailRepository>((ref) {
  final movieDetailApi = ref.watch(movieDetailApiProvider);
  return MovieDetailRepository(movieDetailApi);
});

final class MovieDetailRepository with DioExceptionMapper implements IMovieDetailRepository {
  final MovieDetailApi _movieDetailApi;

  MovieDetailRepository(this._movieDetailApi);

  @override
  Future<MovieResponse> getMovieDetail(String id) async {
    try {
      final response = await _movieDetailApi.getMovieDetail(id);

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

  @override
  Future<MoviesResponse> getMovies(int page, int pageSize) async {
    try {
      final response = await _movieDetailApi.getMovies(page, pageSize);

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