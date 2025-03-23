import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/search/application/isearch_service.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_search_response/top_search_response.dart';
import 'package:ani4h_app/features/search/data/repository/isearch_repository.dart';
import 'package:ani4h_app/features/search/data/repository/search_repository.dart';
import 'package:ani4h_app/features/search/domain/mapper/isearch_result_model_mapper.dart';
import 'package:ani4h_app/features/search/domain/mapper/itop_search_model_mapper.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:ani4h_app/features/search/domain/model/top_search_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';


final searchServiceProvider = Provider<ISearchService>((ref) {
  final searchRepository = ref.watch(searchRepositoryProvider);
  return SearchService(searchRepository);
});

final class SearchService implements ISearchService, ISearchResultModelMapper, ITopSearchModelMapper {
  final ISearchRepository _searchRepository;

  SearchService(this._searchRepository);

  @override
  Future<Result<List<SearchResultModel>, Failure>> search(String query, int page, int pageSize) async {
    try{
      final response = await _searchRepository.search(query, page, pageSize);

      final models = mapToSearchResultModel(response);

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
  Future<Result<List<TopSearchModel>, Failure>> getTopSearch() async {
    try {
      final response = await _searchRepository.getTopSearch();

      final models = mapToTopSearchModel(response);

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
  List<SearchResultModel> mapToSearchResultModel(SearchResultResponse response) {
    return response.data.map((e) => SearchResultModel(
      id: e.id,
      name: e.name,
      description: e.description,
      imageUrl: e.imageUrl,
      national: e.national,
      tags: e.tags,
    )).toList();
  }

  @override
  List<TopSearchModel> mapToTopSearchModel(TopSearchResponse response) {
    return response.data.map((e) => TopSearchModel(
      id: e.id,
      name: e.name,
      national: e.national,
      imageUrl: e.imageUrl,
      tags: e.tags,
    )).toList();
  }
}