import 'package:freezed_annotation/freezed_annotation.dart';

import '../search_result_response/search_result_response.dart' show SearchResult;

part 'top_hot_response.freezed.dart';
part 'top_hot_response.g.dart';

@freezed
sealed class TopHotResponse with _$TopHotResponse {
  const factory TopHotResponse({
    required List<SearchResult> data,
  }) = _TopHotResponse;

  factory TopHotResponse.fromJson(Map<String, dynamic> json) =>
      _$TopHotResponseFromJson(json);
}


