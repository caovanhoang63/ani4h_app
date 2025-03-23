import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_response.freezed.dart';
part 'search_result_response.g.dart';

@freezed
sealed class SearchResultResponse with _$SearchResultResponse {
  const factory SearchResultResponse({
    required List<SearchResult> data,
  }) = _SearchResultResponse;

  factory SearchResultResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResultResponseFromJson(json);
}

@freezed
sealed class SearchResult with _$SearchResult {
  const factory SearchResult({
    required String id,
    required String name,
    required String national,
    required String imageUrl,
    required String description,
    required List<String> tags,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}