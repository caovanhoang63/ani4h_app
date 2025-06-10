import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_detail_state.freezed.dart';

@freezed
sealed class MovieDetailState with _$MovieDetailState {
  const factory MovieDetailState({
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
    @Default(false) bool isIntroPanelOn,
    @Default(false) bool isPlaylistPanelOn,
    @Default(false) bool isCommentPanelOn,
    @Default(false) bool isCharacterExpandOn,
    @Default(false) bool isProducerExpandOn,
    @Default(false) bool isStudioExpandOn,
  }) = _MovieDetailState;
}