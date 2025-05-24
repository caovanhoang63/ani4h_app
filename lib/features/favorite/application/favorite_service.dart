import 'package:ani4h_app/common/dtos/paging.dart';
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
  Future<Result<List<FavoriteModel>, Failure>> getFavorites(String userId, Paging paging) async {
    try {
      final response = await _favoriteRepository.getFavorites(userId, paging);

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
  Future<Result<bool, Failure>> addFavorite(String userId, String filmId) async {
    try {
      await _favoriteRepository.addFavorite(userId, filmId);
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
  Future<Result<bool, Failure>> deleteFavorite(String userId, String filmId) async {
    try {
      await _favoriteRepository.deleteFavorite(userId, filmId);
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
      title: e.title,
      synopsis: e.synopsis,
      synonyms: e.synonyms,
      jaName: e.jaName,
      enName: e.enName,
      imageUrl: e.images.isNotEmpty ? e.images.first.url : '',
      genres: e.genres,
      avgStar: e.avgStar,
      totalStar: e.totalStar,
      maxEpisodes: e.maxEpisodes,
      numEpisodes: e.numEpisodes,
      year: e.year,
      season: e.season,
    )).toList();
  }
}