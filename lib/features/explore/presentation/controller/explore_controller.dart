
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

  Future<void> fetchExplores(ExploreParams filter, PagingSearch paging) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(exploreServiceProvider).getExplore(filter, paging);

      result.when(
        (success) {
          state = state.copyWith(
            explores: success,
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


  Future<void> fetchGenres() async {
    try {
      final result = await ref.read(exploreServiceProvider).getGenres();

      result.when(
        (success) {
          state = state.copyWith(
            genres: success,
            hasError: false,
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
}