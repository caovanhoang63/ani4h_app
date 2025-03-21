import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:ani4h_app/features/search/domain/model/top_search_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

@freezed
sealed class SearchState with _$SearchState{
  const factory SearchState({
    @Default([]) List<SearchResultModel> searchResults,
    @Default([]) List<TopSearchModel> topSearches,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _SearchState;
}