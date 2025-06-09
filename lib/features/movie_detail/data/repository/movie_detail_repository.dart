import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/favorite_add_request/favorite_add_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<MovieDetailResponse> getMovieDetail(String id) async {
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
  Future<bool> getIsFavorite(String userId, String filmId) async {
    try {
      return await _movieDetailApi.isFavorite(userId, filmId);
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
  Future<void> addToFavorite(FavoriteAddRequest request) {
    try {
      return _movieDetailApi.addToFavorite(request);
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
  Future<void> removeFromFavorite(String userId, String filmId) {
    try {
      return _movieDetailApi.removeFromFavorite(userId, filmId);
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