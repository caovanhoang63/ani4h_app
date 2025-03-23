import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_search_response.freezed.dart';
part 'top_search_response.g.dart';

@freezed
abstract class TopSearchResponse with _$TopSearchResponse {
  const factory TopSearchResponse({
    required List<TopSearch> data,
  }) = _TopSearchResponse;

  factory TopSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$TopSearchResponseFromJson(json);
}

@freezed
abstract class TopSearch with _$TopSearch {
  const factory TopSearch({
    required String id,
    required String name,
    required String national,
    required String imageUrl,
    required List<String> tags,
  }) = _TopSearch;

  factory TopSearch.fromJson(Map<String, dynamic> json) =>
      _$TopSearchFromJson(json);
}