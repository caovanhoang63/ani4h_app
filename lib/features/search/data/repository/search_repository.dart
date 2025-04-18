import 'dart:developer';

import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
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
  Future<SearchResultResponse> search(SearchRequest request, PagingSearch paging) async {
    try {
      log("Search Response: start");

      final response = await _searchApi.search(request.toJson(), paging.toJson());
      log("Search Response: success");
      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: e.toString(),
        stackTrace: s,
      );
    }
  }
}