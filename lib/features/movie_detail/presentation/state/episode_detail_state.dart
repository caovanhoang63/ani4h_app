import 'package:ani4h_app/features/movie_detail/domain/model/episode_detail_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode_detail_state.freezed.dart';

@freezed
sealed class EpisodeDetailState with _$EpisodeDetailState {
  const factory EpisodeDetailState({
    @Default(null) EpisodeDetailModel? episodeDetail,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _EpisodeDetailState;
}