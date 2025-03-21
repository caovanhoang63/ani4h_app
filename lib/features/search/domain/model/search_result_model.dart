import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_model.freezed.dart';
@freezed
sealed class SearchResultModel with _$SearchResultModel {
  const factory SearchResultModel({
    required String id,
    required String name,
    required String nation,
    required String imageUrl,
    required String tags,
    required String description,
  }) = _SearchResultModel;
}