import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/search/application/isearch_service.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/repository/isearch_repository.dart';
import 'package:ani4h_app/features/search/data/repository/search_repository.dart';
import 'package:ani4h_app/features/search/domain/mapper/isearch_result_model_mapper.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';


final searchServiceProvider = Provider<ISearchService>((ref) {
  final searchRepository = ref.watch(searchRepositoryProvider);
  return SearchService(searchRepository);
});

final class SearchService implements ISearchService, ISearchResultModelMapper {
  final ISearchRepository _searchRepository;

  SearchService(this._searchRepository);

  @override
  Future<Result<SearchResultModel, Failure>> search(String query, PagingSearch pageCur) async {
    try{
      final searchRequest = mapToSearchRequest(query, "", pageCur);
      final response = await _searchRepository.search(searchRequest);

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
  SearchResultModel mapToSearchResultModel(SearchResultResponse response) {
    SearchResultModel searchResultModel = SearchResultModel(
      data: response.data.data.map((e) => FilmCardModel(
        id: e.id,
        title: e.title,
        synopsis: e.synopsis,
        imageUrl: e.images.length > 0 ? e.images[0].url : "",
        genres: e.genres,
      )).toList(),
      paging: response.data.paging,
    );
    return searchResultModel;
  }

  SearchRequest mapToSearchRequest(String title, String genre, PagingSearch paging) {
    return SearchRequest(
      title: title,
      genre: genre,
      score: paging.score == 0 ? null : paging.score,
      uid: paging.uid == "" ? null : paging.uid,
    );
  }
}