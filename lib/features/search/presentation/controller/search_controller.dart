import 'dart:developer';

import 'package:ani4h_app/features/search/application/search_service.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/presentation/state/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchControllerProvider = AutoDisposeNotifierProvider<SearchController, SearchState>(SearchController.new);

class SearchController extends AutoDisposeNotifier<SearchState>{

  @override
  SearchState build() {
    return SearchState();
  }

  void reset() {
    log("Reset");
  }

  Future<void> search(String title) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      SearchRequest request = SearchRequest(
        title: title,
        year: 0,
      );

      final result = await ref.read(searchServiceProvider).search(request, state.paging);

      result.when(
        (success) {
          log("Search Result: $success");
          state = state.copyWith(
            searchResults: success.data,
            paging: success.paging,
            isLoading: false,
            hasError: false,
          );
        },
        (failure) {
          log("Failure: $failure");
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: failure.message,
          );
        },
      );
    } catch (e) {
      log("Error: $e");
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  // fetch more search result
  Future<void> fetchMoreSearch(String title) async {
    if(state.paging.nextCursor == null) {
      log("No more data");
      return;
    }

    try {
      SearchRequest request = SearchRequest(
        title: title,
        year: 0,
      );

      final result = await ref.read(searchServiceProvider).search(request, state.paging);

      result.when(
        (success) {
          log("Search Result: $success");
          state = state.copyWith(
            searchResults: state.searchResults + success.data,
            paging: success.paging,
          );
        },
        (failure) {
          log("Failure: $failure");
        },
      );

    } catch (e) {
      log("Error: $e");
    }
  }

  void resetPageCur() {
    state = state.copyWith(
      paging: PagingSearch(
        cursor: "",
        nextCursor: "",
        page: 1,
        pageSize: 10,
      ),
    );
  }
}