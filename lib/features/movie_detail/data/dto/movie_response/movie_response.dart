import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_response.freezed.dart';
part 'movie_response.g.dart';

@freezed
sealed class MovieResponse with _$MovieResponse {
  const factory MovieResponse({
    required Data data,
  }) = _MovieResponse;

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
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
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
sealed class AgeRating with _$AgeRating {
  const factory AgeRating({
    required String id,
    required dynamic shortName,
    required dynamic longName,
    required dynamic description,
    required dynamic image,
    required int minAgeToWatch,
  }) = _AgeRating;

  factory AgeRating.fromJson(Map<String, dynamic> json) => _$AgeRatingFromJson(json);
}

@freezed
sealed class Genre with _$Genre {
  const factory Genre({
    required String id,
    required String name,
  }) = _Genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}

@freezed
sealed class Image with _$Image {
  const factory Image({
    required String id,
    required String url,
    required int width,
    required int height,
    required String extension,
    required String cloudName,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}
