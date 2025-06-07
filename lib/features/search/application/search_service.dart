import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/search/application/isearch_service.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_hot_response/top_hot_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_favorite_response/user_favorite_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_history_response/user_history_response.dart';
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
  Future<Result<SearchResultModel, Failure>> search(SearchRequest request, PagingSearch paging) async {
    try{
      PagingSearch pagingRequest = PagingSearch(
        cursor: paging.nextCursor,
        nextCursor: paging.nextCursor,
        page: paging.page,
        pageSize: paging.pageSize,
      );

      final response = await _searchRepository.search(request, pagingRequest);

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
        genres: e.genres ?? const [],
      )).toList(),
      paging: response.data.paging,
    );
    return searchResultModel;
  }

  @override
  SearchResultModel mapToSearchResultModelFromTopHotResponse(TopHotResponse response){
    SearchResultModel searchResultModel = SearchResultModel(
      data: response.data.map((e) => FilmCardModel(
        id: e.id,
        title: e.title,
        synopsis: e.synopsis,
        imageUrl: e.images.length > 0 ? e.images[0].url : "",
        genres: e.genres ?? const [],
      )).toList(),
      paging: PagingSearch(
        cursor: "",
        nextCursor: "",
        page: 1,
        pageSize: 10,
      ),
    );
    return searchResultModel;
  }

  @override
  Future<Result<SearchResultModel, Failure>> getTopHot(Paging paging) async {
    try{
      final response = await _searchRepository.getTopHot(paging);

      final models = mapToSearchResultModelFromTopHotResponse(response);

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
  SearchResultModel mapToSearchResultModelFromUserFavoriteResponse(UserFavoriteResponse response) {

    return SearchResultModel(
      data: response.data.data.map((e) => FilmCardModel(
        id: e.id,
        title: e.title,
        synopsis: e.synopsis,
        imageUrl: e.images.length > 0 ? e.images[0].url : "",
        genres: e.genres,
      )).toList(),
      paging: PagingSearch(
        cursor: "",
        nextCursor: "",
        page: 1,
        pageSize: 10,
      ),
    );
  }

  @override
  Future<Result<SearchResultModel, Failure>> getUserFavorites(int seed, Paging pageCur) async {
    try {
      final response = await _searchRepository.getUserFavorites(seed, pageCur);

      final models = mapToSearchResultModelFromUserFavoriteResponse(response);

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
  Future<Result<SearchResultModel, Failure>> getUserHistory(int seed, Paging pageCur) async {
    try {
      final response = await _searchRepository.getUserHistorySuggestion(seed, pageCur);

      final models = mapToSearchResultModelFromUserHistoryResponse(response);

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
  SearchResultModel mapToSearchResultModelFromUserHistoryResponse(UserHistoryResponse response) {
    return SearchResultModel(
      data: response.data.data.map((e) => FilmCardModel(
        id: e.id,
        title: e.title,
        synopsis: e.synopsis,
        imageUrl: e.images.length > 0 ? e.images[0].url : "",
        genres: e.genres ?? const [],
      )).toList(),
      paging: PagingSearch(
        cursor: "",
        nextCursor: "",
        page: 1,
        pageSize: 10,
      ),
    );
  }
}