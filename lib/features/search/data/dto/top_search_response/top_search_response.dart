import 'package:ani4h_app/common/dtos/image.dart';
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
    required String title,
    required String synopsis,
    required List<Image> images,
    required List<String> genres,
  }) = _TopSearch;

  factory TopSearch.fromJson(Map<String, dynamic> json) =>
      _$TopSearchFromJson(json);
}