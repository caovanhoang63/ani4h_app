import 'package:ani4h_app/features/explore/application/explore_service.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/presentation/state/explore_state.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final exploreControllerProvider = AutoDisposeNotifierProvider<ExploreController, ExploreState>(ExploreController.new);

class ExploreController extends AutoDisposeNotifier<ExploreState> {
  @override
  ExploreState build() {
    return ExploreState();
  }

  Future<void> fetchExplores(ExploreParams filter) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        filter: filter,
      );

      resetPageCur();

      print("Fetching explores with filter: $filter");
      final result = await ref.read(exploreServiceProvider).getExplore(filter, state.paging);

      result.when(
        (success) {
          print("Fetched explores successfully: ${success.data.length} items");
          state = state.copyWith(
            explores: success.data,
            paging: success.paging,
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

  Future<void> fetchMoreExplores() async {
    if (!state.hasMore) return;

    try {

      final result = await ref.read(exploreServiceProvider).getExplore(state.filter, state.paging);

      result.when(
        (success) {
          state = state.copyWith(
            explores: [...state.explores, ...success.data],
            paging: success.paging,
            hasMore: success.paging.nextCursor != null,
            hasError: false,
          );
        },
        (failure) {
          state = state.copyWith(
            hasError: true,
            errorMessage: failure.message,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchGenres() async {
    try {
      final result = await ref.read(exploreServiceProvider).getGenres();

      result.when(
        (success) {
          state = state.copyWith(
            genres: success,
            genreSelections: [
              {"name": "Tất cả", "value": ""},
              ...success.map((genre) => {"name": genre.name, "value": genre.id}),
            ],
          );
        },
        (failure) {
          state = state.copyWith(
            hasError: true,
            isLoading: false,
            errorMessage: failure.message,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        isLoading: false,
        errorMessage: e.toString(),
      );
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