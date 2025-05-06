import 'package:ani4h_app/common/provider/current_movie_state/current_movie_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/movie_detail/application/movie_detail_service.dart';
import '../../../features/movie_detail/domain/model/movie_model.dart';


final currentMovieControllerProvider = NotifierProvider<CurrentMovieController, CurrentMovieState>(CurrentMovieController.new);

class CurrentMovieController extends Notifier<CurrentMovieState> {
  @override
  CurrentMovieState build() {
    return CurrentMovieState();
  }

  void clearCurrentMovie() {
    state = state.copyWith(movieDetail: null);
  }

  Future<void> fetchCurrentMovie(String id) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(movieDetailServiceProvider).getMovieDetail(id);
      result.when(
        (success) {
          state = state.copyWith(
            movieDetail: success,
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
        errorMessage: e.toString()
      );
    }
  }

  Future<void> fetchSuggestedMovies() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );
      final result = await ref.read(movieDetailServiceProvider).getSuggestedMovies(1, 5);
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