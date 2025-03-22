import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_response.freezed.dart';
part 'favorite_response.g.dart';
@freezed
sealed class FavoriteResponse with _$FavoriteResponse {
  const factory FavoriteResponse({
    required List<Favorite> data,
  }) = _FavoriteResponse;

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) => _$FavoriteResponseFromJson(json);
}

@freezed
sealed class Favorite with _$Favorite {
  const factory Favorite({
    required String id,
    required String name,
    required String imageUrl,
    required String national,
    required List<String> tags,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
}

