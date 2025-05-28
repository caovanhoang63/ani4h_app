import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_model.freezed.dart';

@freezed
abstract class ExploreModel with _$ExploreModel {
  const factory ExploreModel({
    required List<ExploreCardModel> data,
    required PagingSearch paging,
  }) = _ExploreModel;
}

@freezed
abstract class ExploreCardModel with _$ExploreCardModel {
  const factory ExploreCardModel({
    required String id,
    required String title,
    required String imageUrl,
  }) = _ExploreCardModel;
}