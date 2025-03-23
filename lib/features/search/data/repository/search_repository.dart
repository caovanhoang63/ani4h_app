import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_search_response/top_search_response.dart';
import 'package:ani4h_app/features/search/data/repository/isearch_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ani4h_app/features/search/data/source/remote/search_api.dart';

final searchRepositoryProvider = Provider<ISearchRepository>((ref) {
  final searchApi = ref.watch(searchApiProvider);
  return SearchRepository(searchApi);
});

final class SearchRepository with DioExpceptionMapper implements ISearchRepository {
  final SearchApi _searchApi;

  SearchRepository(this._searchApi);

  @override
  Future<SearchResultResponse> search(String query, int page, int pageSize) async {
    try {
      final response = await _searchApi.search(query, page, pageSize);
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
  Future<TopSearchResponse> getTopSearch() async {
    try {
      final response = await _searchApi.getTopSearch();
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