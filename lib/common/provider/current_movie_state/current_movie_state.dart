import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../features/movie_detail/domain/model/movie_model.dart';

part 'current_movie_state.freezed.dart';

@freezed
sealed class CurrentMovieState with _$CurrentMovieState {
  const factory CurrentMovieState({
    @Default(null) MovieModel? movieDetail,
    @Default([]) List<MovieModel> suggestedMovies,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _CurrentMovieState;
}