import 'package:ani4h_app/features/home/application/home_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/home_state.dart';

final homeControllerProvider = AutoDisposeNotifierProvider<HomeController, HomeState>(HomeController.new);

class HomeController extends AutoDisposeNotifier<HomeState> {

  @override
  HomeState build() {
    return HomeState();
  }

  Future<void> fetchMovie() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(homeServiceProvider).getMovies(1, 10);

      state = state.copyWith(
        movies: result,
        isLoading: false,
        hasError: false,
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