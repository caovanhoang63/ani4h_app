import 'package:ani4h_app/common/dtos/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_model.freezed.dart';
@freezed
sealed class SearchResultModel with _$SearchResultModel {
  const factory SearchResultModel({
    required String id,
    required String title,
    required String synopsis,
    required String imageUrl,
    required List<String> genres,
  }) = _SearchResultModel;
}