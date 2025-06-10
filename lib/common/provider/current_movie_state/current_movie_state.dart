import 'package:ani4h_app/features/movie_detail/domain/model/episode_detail_model.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_detail_model.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_movie_state.freezed.dart';

@freezed
sealed class CurrentMovieState with _$CurrentMovieState {
  const factory CurrentMovieState({
    @Default(null) MovieDetailModel? movieDetail,
    @Default([]) List<EpisodeDetailModel> episodes,
    @Default([]) List<FilmCardModel> similarMovies,
    @Default(false) bool isFavorite,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _CurrentMovieState;
}