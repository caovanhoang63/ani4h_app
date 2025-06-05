import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:ani4h_app/common/dtos/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_response.freezed.dart';
part 'search_result_response.g.dart';

@freezed
sealed class SearchResultResponse with _$SearchResultResponse {
  const factory SearchResultResponse({
    required SearchResponse data,
  }) = _SearchResultResponse;

  factory SearchResultResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResultResponseFromJson(json);
}

@freezed
sealed class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    required List<SearchResult> data,
    required PagingSearch paging,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

@freezed
sealed class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String id,
    required String title,
    required String synopsis,
    required List<Image> images,
    List<Genre>? genres,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@freezed
sealed class PagingSearch with _$PagingSearch {
  const factory PagingSearch({
    String? cursor,
    String? nextCursor,
    required int page,
    required int pageSize,
  }) = _PagingSearch;

  factory PagingSearch.fromJson(Map<String, dynamic> json) =>
      _$PagingSearchFromJson(json);
}
