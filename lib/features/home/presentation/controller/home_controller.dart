import 'dart:developer';

import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/features/search/application/search_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/home_state.dart';

final homeControllerProvider = AutoDisposeNotifierProvider<HomeController, HomeState>(HomeController.new);

class HomeController extends AutoDisposeNotifier<HomeState> {

  @override
  HomeState build() {
    return HomeState();
  }

  Future<void> fetchCarouselMovies() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );
      Paging paging = Paging(
        page: 1,
        pageSize: 6,
      );

      final result = await ref.read(searchServiceProvider).getTopHot(paging);
      result.when(
        (success) {
          state = state.copyWith(
            carouselMovies: success.data,
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

  Future<void> fetchTopHot() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      Paging paging = Paging(
        page: 1,
        pageSize: 10,
      );

      final result = await ref.read(searchServiceProvider).getTopHot(paging);

      result.when(
            (success) {
          log("Top Hot Result: $success");
          state = state.copyWith(
            topSearches: success.data,
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

  Future<void> fetchUserFavorite() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      Paging paging = Paging(
        page: 1,
        pageSize: 10,
      );

      final result = await ref.read(searchServiceProvider).getUserFavorites(1, paging);

      result.when(
            (success) {
          log("User Favorite Result: $success");
          state = state.copyWith(
            userFavorite: success.data,
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

  Future<void> fetchUserHistorySuggestion() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      Paging paging = Paging(
        page: 1,
        pageSize: 10,
      );

      final result = await ref.read(searchServiceProvider).getUserHistory(1, paging);

      result.when(
            (success) {
          log("User History Suggestion Result: $success");
          state = state.copyWith(
            userHistorySuggestion: success.data,
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
}