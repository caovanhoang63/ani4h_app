import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:ani4h_app/common/dtos/image.dart';
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
    @Default("")String title,
    @Default("")String synopsis,
    @Default("")String synonyms,
    @Default("")String jaName,
    @Default("")String enName,
    @Default([])List<Image> images,
    @Default([])List<Genre> genres,
    @Default(10)double avgStar,
    @Default(10)int totalStar,
    @Default(0)int maxEpisodes,
    @Default(0)int numEpisodes,
    @Default(2000)int year,
    @Default("")String season,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
}

