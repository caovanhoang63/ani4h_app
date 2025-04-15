import 'package:ani4h_app/features/home/application/home_service.dart';
import 'package:ani4h_app/features/home/domain/model/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/home_state.dart';

final homeControllerProvider = AutoDisposeNotifierProvider<HomeController, HomeState>(HomeController.new);

class HomeController extends AutoDisposeNotifier<HomeState> {

  @override
  HomeState build() {
    return HomeState();
  }

  Future<void> fetchMovies() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );
      final result = await ref.read(homeServiceProvider).getMovies(1, 5);
      result.when(
        (success) {
          state = state.copyWith(
            suggestedMovies: List<MovieModel>.from(success),
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