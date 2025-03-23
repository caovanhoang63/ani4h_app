import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_search_model.freezed.dart';

@freezed
sealed class TopSearchModel with _$TopSearchModel {
  const factory TopSearchModel({
    required String id,
    required String name,
    required String national,
    required String imageUrl,
    required List<String> tags,
  }) = _TopSearchModel;
}