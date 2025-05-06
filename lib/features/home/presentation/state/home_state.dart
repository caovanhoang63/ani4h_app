import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/model/movie_model.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<MovieModel> suggestedMovies,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _HomeState;
}