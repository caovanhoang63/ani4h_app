import 'package:ani4h_app/common/provider/user_id_state/user_id_state_provider.dart';
import 'package:ani4h_app/core/data/local/secure_storage/secure_storage.dart';
import 'package:ani4h_app/features/history/data/dto/upsert_request/upsert_request.dart';
import 'package:ani4h_app/features/history/data/source/remote/history_api.dart';
import 'package:ani4h_app/features/movie_detail/presentation/state/movie_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieDetailControllerProvider = AutoDisposeNotifierProvider<MovieDetailController, MovieDetailState>(MovieDetailController.new);

class MovieDetailController extends AutoDisposeNotifier<MovieDetailState> {
  @override
  MovieDetailState build() {
    return MovieDetailState();
  }

  Future<void> startWatch(String episodeId) async {
    final userId = await ref.watch(secureStorageProvider).read("userIdState");

    if (userId != null) {
      final req = UpsertRequest(
          userId : userId,
          episodeId : episodeId,
          watchedDuration : 0
      );

      ref.read(historyApiProvider).upsertHistory(req);
    }
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

  void toggleCharacterPanel() {
    state = state.copyWith(
      isCharacterExpandOn: !state.isCharacterExpandOn,
    );
  }

  void toggleProducerPanel() {
    state = state.copyWith(
      isProducerExpandOn: !state.isProducerExpandOn,
    );
  }

  void toggleStudioPanel() {
    state = state.copyWith(
      isStudioExpandOn: !state.isStudioExpandOn,
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