import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_search_model.freezed.dart';

@freezed
sealed class TopSearchModel with _$TopSearchModel {
  const factory TopSearchModel({
    required String id,
    required String name,
    required String nation,
    required String imageUrl,
    required String tags,
  }) = _TopSearchModel;
}