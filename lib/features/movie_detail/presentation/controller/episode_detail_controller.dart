import 'package:ani4h_app/features/movie_detail/application/episode_detail_service.dart';
import 'package:ani4h_app/features/movie_detail/application/iepisode_detail_service.dart';
import 'package:ani4h_app/features/movie_detail/presentation/state/episode_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final episodeDetailControllerProvider = StateNotifierProvider.autoDispose<EpisodeDetailController, EpisodeDetailState>((ref) {
  final episodeDetailService = ref.watch(episodeDetailServiceProvider);
  return EpisodeDetailController(episodeDetailService);
});

class EpisodeDetailController extends StateNotifier<EpisodeDetailState> {
  final IEpisodeDetailService _episodeDetailService;

  EpisodeDetailController(this._episodeDetailService) : super(const EpisodeDetailState());

  Future<void> getEpisodeDetail(String id) async {
    state = state.copyWith(isLoading: true, hasError: false, errorMessage: '');

    final result = await _episodeDetailService.getEpisodeDetail(id);

    result.when(
      success: (episodeDetail) {
        state = state.copyWith(
          episodeDetail: episodeDetail,
          isLoading: false,
        );
      },
      error: (failure) {
        state = state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: failure.message,
        );
      },
    );
  }
}