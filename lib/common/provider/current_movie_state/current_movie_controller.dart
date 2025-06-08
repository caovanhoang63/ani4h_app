import 'package:ani4h_app/common/provider/current_movie_state/current_movie_state.dart';
import 'package:ani4h_app/features/movie_detail/application/episode_detail_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/movie_detail/application/movie_detail_service.dart';


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
        (success) async {
          state = state.copyWith(
            movieDetail: success,
            isLoading: false,
            hasError: false,
          );

          final episodesRes =  await ref.read(episodeDetailServiceProvider).getListEpisodes(success.id);
          episodesRes.when(
            (episodes) {
              state = state.copyWith(
                episodes: episodes,
              );
            },
            (failure) {
              state = state.copyWith(
                hasError: true,
                errorMessage: failure.message,
              );
            },
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
}