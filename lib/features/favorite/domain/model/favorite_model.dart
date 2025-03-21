import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.freezed.dart';

@freezed
sealed class FavoriteModel with _$FavoriteModel {
  const factory FavoriteModel({
    required String id,
    required String userId,
    required String movieId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FavoriteModel;
}