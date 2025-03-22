import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/favorite/application/ifavorite_service.dart';
import 'package:ani4h_app/features/favorite/data/dto/favorite_response/favorite_response.dart';
import 'package:ani4h_app/features/favorite/data/repository/favorite_repository.dart';
import 'package:ani4h_app/features/favorite/data/repository/ifavorite_repository.dart';
import 'package:ani4h_app/features/favorite/domain/mapper/ifavorite_model_mapper.dart';
import 'package:ani4h_app/features/favorite/domain/model/favorite_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

final favoriteServiceProvider = Provider<IFavoriteService>((ref) {
  final favoriteRepository = ref.watch(favoriteRepositoryProvider);
  return FavoriteService(favoriteRepository);
});

final class FavoriteService implements IFavoriteService, IFavoriteModelMapper {
  final IFavoriteRepository _favoriteRepository;

  FavoriteService(this._favoriteRepository);

  @override
  Future<Result<List<FavoriteModel>, Failure>> getFavorites(int page, int pageSize) async {
    try {
      final response = await _favoriteRepository.getFavorites(page, pageSize);

      final models = mapToFavoriteModel(response);

      return Result.success(models);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Result<bool, Failure>> addFavorite(int id) async {
    try {
      await _favoriteRepository.addFavorite(id);
      return const Result.success(true);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  Future<Result<bool, Failure>> removeFavorite(int id) async {
    try {
      await _favoriteRepository.deleteFavorite(id);
      return const Result.success(true);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  List<FavoriteModel> mapToFavoriteModel(FavoriteResponse response) {
    return response.data.map((e) => FavoriteModel(
      id: e.id,
      name: e.name,
      national: e.national,
      imageUrl: e.imageUrl,
      tags: e.tags,
    )).toList();
  }
}