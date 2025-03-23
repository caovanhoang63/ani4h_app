import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_model.freezed.dart';
@freezed
sealed class SearchResultModel with _$SearchResultModel {
  const factory SearchResultModel({
    required String id,
    required String name,
    required String national,
    required String imageUrl,
    required List<String> tags,
    required String description,
  }) = _SearchResultModel;
}