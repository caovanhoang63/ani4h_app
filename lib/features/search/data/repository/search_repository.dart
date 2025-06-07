import 'dart:developer';

import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_hot_response/top_hot_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_favorite_response/user_favorite_response.dart' hide Paging;
import 'package:ani4h_app/features/search/data/repository/isearch_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ani4h_app/features/search/data/source/remote/search_api.dart';

final searchRepositoryProvider = Provider<ISearchRepository>((ref) {
  final searchApi = ref.watch(searchApiProvider);
  return SearchRepository(searchApi);
});

final class SearchRepository with DioExceptionMapper implements ISearchRepository {
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

  @override
  Future<TopHotResponse> getTopHot(Paging paging) async {
    try {
      log("Get Top Hot Response: start");

      final response = await _searchApi.getTopHot(paging.page, paging.pageSize);
      log("Get Top Hot Response: success");
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

  @override
  Future<UserFavoriteResponse> getUserFavorites(int seed, Paging paging) async {
    try {
      log("Get User Favorites Response: start");

      final response = await _searchApi.getUserFavorite(seed, paging.page, paging.pageSize);
      log("Get User Favorites Response: success");
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