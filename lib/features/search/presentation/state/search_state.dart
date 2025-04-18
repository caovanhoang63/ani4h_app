import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
sealed class SearchState with _$SearchState{
  const factory SearchState({
    @Default([]) List<FilmCardModel> searchResults,
    @Default([]) List<FilmCardModel> topSearches,
    @Default(PagingSearch(
      cursor: "",
      nextCursor: "",
      page: 1,
      pageSize: 10,
    )) PagingSearch paging,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _SearchState;
}