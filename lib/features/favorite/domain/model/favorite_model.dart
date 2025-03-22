import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.freezed.dart';

@freezed
sealed class FavoriteModel with _$FavoriteModel {
  const factory FavoriteModel({
    required String id,
    required String name,
    required String national,
    required String imageUrl,
    required List<String> tags,
  }) = _FavoriteModel;
}