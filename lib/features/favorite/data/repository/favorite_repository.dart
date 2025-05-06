import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/favorite/data/dto/favorite_response/favorite_response.dart';
import 'package:ani4h_app/features/favorite/data/repository/ifavorite_repository.dart';
import 'package:ani4h_app/features/favorite/data/source/remote/favorite_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteRepositoryProvider = Provider<IFavoriteRepository>((ref) {
  final favoriteApi = ref.watch(favoriteApiProvider);
  return FavoriteRepository(favoriteApi);
});

final class FavoriteRepository with DioExceptionMapper implements IFavoriteRepository {
  final FavoriteApi _favoriteApi;

  FavoriteRepository(this._favoriteApi);

  @override
  Future<FavoriteResponse> getFavorites(int page, int pageSize)async {
   try{
     final response = await _favoriteApi.getFavorites(page, pageSize);
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
  Future<void> addFavorite(int id) async {
    try {
      await _favoriteApi.addFavorite(id);
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
  Future<void> deleteFavorite(int id) async {
    try {
      await _favoriteApi.deleteFavorite(id);
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