import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/explore/application/iexplore_service.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/explore_response.dart';
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
  Future<Result<List<ExploreModel>, Failure>> getExplore(ExploreParams filter, PagingSearch paging) async {
    try {
      final response = await _exploreRepository.getExplore(filter, paging);

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
  List<ExploreModel> mapToExploreModel(ExploreResponse response) {
    return response.data.map((e) => ExploreModel(
      id: e.id,
      title: e.title,
      imageUrl: e.images[0].url ?? "",
    )).toList();
  }
}