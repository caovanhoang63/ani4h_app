import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_request.freezed.dart';
part 'search_request.g.dart';

@freezed
sealed class SearchRequest with _$SearchRequest {
  const factory SearchRequest({
    String? title,
    String? genre,
    String? uid,
    double? score,
  }) = _SearchRequest;

  factory SearchRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchRequestFromJson(json);
}

extension SearchRequestQueryExtension on SearchRequest {
  Map<String, dynamic> toFilteredQuery() {
    final json = toJson();

    return Map.fromEntries(
      json.entries.where(
            (e) =>
        e.value != null &&
            (e.value is! String || (e.value as String).trim().isNotEmpty),
      ),
    );
  }
}
