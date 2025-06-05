import 'package:ani4h_app/common/dtos/image.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_response.freezed.dart';
part 'explore_response.g.dart';

@freezed
abstract class ExploreResponse with _$ExploreResponse {
  const factory ExploreResponse({
    required ExploreDataPaging data,
  }) = _ExploreResponse;

  factory ExploreResponse.fromJson(Map<String, dynamic> json) => _$ExploreResponseFromJson(json);
}

@freezed
abstract class ExploreDataPaging with _$ExploreDataPaging {
  const factory ExploreDataPaging({
    required List<ExploreData> data,
    required PagingSearch paging,
  }) = _ExploreDataPaging;

  factory ExploreDataPaging.fromJson(Map<String, dynamic> json) => _$ExploreDataPagingFromJson(json);
}

@freezed
abstract class ExploreData with _$ExploreData {
  const factory ExploreData({
    required String id,
    required String title,
    required List<Image> images,
  }) = _ExploreData;

  factory ExploreData.fromJson(Map<String, dynamic> json) => _$ExploreDataFromJson(json);
}