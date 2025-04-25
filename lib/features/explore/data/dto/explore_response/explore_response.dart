import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_response.freezed.dart';
part 'explore_response.g.dart';

@freezed
abstract class ExploreResponse with _$ExploreResponse {
  const factory ExploreResponse({
    required List<ExploreData> data,
  }) = _ExploreResponse;

  factory ExploreResponse.fromJson(Map<String, dynamic> json) => _$ExploreResponseFromJson(json);
}

@freezed
abstract class ExploreData with _$ExploreData {
  const factory ExploreData({
    required String id,
    required String name,
    required String imageUrl,
  }) = _ExploreData;

  factory ExploreData.fromJson(Map<String, dynamic> json) => _$ExploreDataFromJson(json);
}