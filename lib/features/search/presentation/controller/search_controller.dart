import 'dart:developer';

import 'package:ani4h_app/features/search/application/search_service.dart';
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

  Future<void> search(String query, int page, int pageSize) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(searchServiceProvider).search(query, page, pageSize);

      result.when(
        (success) {
          log("Search Result: $success");
          state = state.copyWith(
            searchResults: success,
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

  Future<void> getTopSearch() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(searchServiceProvider).getTopSearch();

      result.when(
        (success) {
          state = state.copyWith(
            topSearches: success,
            isLoading: false,
            hasError: false,
          );
        },
        (failure) {
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: failure.message,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }
}