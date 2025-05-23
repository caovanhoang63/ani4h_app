import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/movie_model.dart';

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
  }) = _MovieDetailState;
}