import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/dto/movie_response/movie_response.dart';

part 'movie_model.freezed.dart';

@freezed
sealed class MovieModel with _$MovieModel {
  const factory MovieModel({
    required String id,
    required String title,
    required DateTime startDate,
    required DateTime? endDate,
    required String? synopsis,
    required List<Image>? images,
    required int? avgStar,
    required int? totalStar,
    required int? maxEpisodes,
    required int? numEpisodes,
    required int? year,
    required String? season,
    required int? averageEpisodeDuration,
    required String? ageRatingId,
    required int status,
    required String state,
    required AgeRating? ageRating,
    required List<Genre>? genres,
    required DateTime createdAt,
    required DateTime updatedAt,
    required dynamic seriesId,
  }) = _MovieModel;
}