import 'package:ani4h_app/common/dtos/image.dart';
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
    required String title,
    required String synopsis,
    required List<Image> images,
    required List<String> genres,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}