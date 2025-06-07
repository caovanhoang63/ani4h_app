import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/dtos/image.dart';

part 'movie_detail_model.freezed.dart';

@freezed
sealed class MovieDetailModel with _$MovieDetailModel {
  const factory MovieDetailModel({
    required String id,
    required String title,
    required DateTime startDate,
    required DateTime? endDate,
    required String synopsis,
    required List<Image> images,
    required int avgStar,
    required int? totalStar,
    required int maxEpisodes,
    required int numEpisodes,
    required int year,
    required String season,
    required int averageEpisodeDuration,
    required String ageRatingId,
    required int status,
    required String state,
    required AgeRating ageRating,
    required List<Genre> genres,
    required List<Character> characters,
    required List<Producer> producers,
    required List<Producer> studios,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String? seriesId,
    required int? view,
  }) = _MovieDetailModel;
}