import 'package:ani4h_app/features/movie_detail/presentation/state/movie_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailControllerProvider = AutoDisposeNotifierProvider<MovieDetailController, MovieDetailState>(MovieDetailController.new);

class MovieDetailController extends AutoDisposeNotifier<MovieDetailState> {
  @override
  MovieDetailState build() {
    return MovieDetailState();
  }

  void openIntroPanel() {
    state = state.copyWith(
      isIntroPanelOn: true,
      isPlaylistPanelOn: false,
      isCommentPanelOn: false,
    );
  }

  void openPlaylistPanel() {
    state = state.copyWith(
      isIntroPanelOn: false,
      isPlaylistPanelOn: true,
      isCommentPanelOn: false,
    );
  }

  void openCommentPanel() {
    state = state.copyWith(
      isIntroPanelOn: false,
      isPlaylistPanelOn: false,
      isCommentPanelOn: true,
    );
  }

  void closeAllPanels() {
    state = state.copyWith(
      isIntroPanelOn: false,
      isPlaylistPanelOn: false,
      isCommentPanelOn: false,
    );
  }
}