import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/explore/application/iexplore_service.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/explore_response.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/list_genre_response.dart';
import 'package:ani4h_app/features/explore/data/repository/explore_repository.dart';
import 'package:ani4h_app/features/explore/data/repository/iexplore_repository.dart';
import 'package:ani4h_app/features/explore/domain/mapper/iexplore_model_mapper.dart';
import 'package:ani4h_app/features/explore/domain/model/explore_model.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

final exploreServiceProvider = Provider<IExploreService>((ref) {
  final exploreRepository = ref.watch(exploreRepositoryProvider);
  return ExploreService(exploreRepository);
});

final class ExploreService implements IExploreService, IExploreModelMapper {
  final IExploreRepository _exploreRepository;

  ExploreService(this._exploreRepository);

  @override
  Future<Result<ExploreModel, Failure>> getExplore(ExploreParams filter, PagingSearch paging) async {
    try {
      PagingSearch pagingRequest = PagingSearch(
        cursor: paging.nextCursor,
        nextCursor: paging.nextCursor,
        page: paging.page,
        pageSize: paging.pageSize,
      );

      final response = await _exploreRepository.getExplore(filter, pagingRequest);

      final models = mapToExploreModel(response);

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
  ExploreModel mapToExploreModel(ExploreResponse response) {
    ExploreModel exploreModel = ExploreModel(
      data: response.data.data.map((e) => ExploreCardModel(
        id: e.id,
        title: e.title,
        imageUrl: e.images.isNotEmpty ? e.images[0].url : "",
      )).toList(),
      paging: response.data.paging,
    );
    return exploreModel;
  }

  List<Genre> mapToListGenreResponse(ListGenreResponse response) {
    return response.data.map((e) => Genre(
      id: e.id,
      name: e.name,
    )).toList();
  }

  @override
  Future<Result<List<Genre>, Failure>> getGenres() async {
    try {
      final response = await _exploreRepository.getGenres();
      final genres = mapToListGenreResponse(response);

      return Result.success(genres);
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
}