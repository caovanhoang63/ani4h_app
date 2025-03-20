import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_request/login_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_response/login_response.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/users_response/users_response.dart';
import 'package:ani4h_app/features/movie_detail/data/source/local/itoken_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../source/local/token_storage.dart';
import '../source/remote/movie_detail_api.dart';
import 'imovie_detail_repository.dart';

final movieDetailRepositoryProvider = Provider<IMovieDetailRepository>((ref) {
  final movieDetailApi = ref.watch(movieDetailApiProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  return MovieDetailRepository(movieDetailApi, tokenStorage);
});

final class MovieDetailRepository with DioExpceptionMapper implements IMovieDetailRepository {
  final MovieDetailApi _movieDetailApi;
  final ITokenStorage _tokenStorage;

  MovieDetailRepository(this._movieDetailApi, this._tokenStorage);

  @override
  Future<UsersResponse> getUsers(int page, int pageSize) async {
    try {
      final response = await _movieDetailApi.getUsers(page, pageSize);
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

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _movieDetailApi.login(request);

      final accessToken = response.data.accessToken;
      final refreshToken = response.data.refreshToken;

      await _tokenStorage.storeToken(accessToken, refreshToken);

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