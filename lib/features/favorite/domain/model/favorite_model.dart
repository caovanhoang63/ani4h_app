import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_model.freezed.dart';

@freezed
sealed class FavoriteModel with _$FavoriteModel {
  const factory FavoriteModel({
    required String id,
    required String title,
    required String synopsis,
    required String synonyms,
    required String jaName,
    required String enName,
    required String imageUrl,
    required List<Genre> genres,
    required double avgStar,
    required int totalStar,
    required int maxEpisodes,
    required int numEpisodes,
    required int year,
    required String season,
  }) = _FavoriteModel;
}