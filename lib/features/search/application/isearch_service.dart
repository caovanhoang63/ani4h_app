import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class ISearchService {
  Future<Result<SearchResultModel, Failure>> search(SearchRequest request, PagingSearch pageCur);
  Future<Result<SearchResultModel, Failure>> getTopHot(Paging pageCur);
  Future<Result<SearchResultModel, Failure>> getUserFavorites(String? userId, int seed, Paging pageCur);
  Future<Result<SearchResultModel, Failure>> getUserHistory(String? userId, int seed, Paging pageCur);
  Future<Result<SearchResultModel, Failure>> getContentBasedSuggestion(String filmId, int seed, Paging pageCur);
}