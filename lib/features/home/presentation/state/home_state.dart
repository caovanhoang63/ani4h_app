import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<FilmCardModel> carouselMovies,
    @Default([]) List<FilmCardModel> topSearches,
    @Default([]) List<FilmCardModel> userFavorite,
    @Default([]) List<FilmCardModel> userHistorySuggestion,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _HomeState;
}