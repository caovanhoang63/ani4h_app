import 'package:freezed_annotation/freezed_annotation.dart';

part 'top_search_model.freezed.dart';

@freezed
sealed class TopSearchModel with _$TopSearchModel {
  const factory TopSearchModel({
    required String id,
    required String title,
    required String synopsis,
    required String imageUrl,
    required List<String> genres,
  }) = _TopSearchModel;
}