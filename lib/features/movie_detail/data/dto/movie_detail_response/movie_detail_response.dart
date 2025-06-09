import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/dtos/image.dart';

part 'movie_detail_response.freezed.dart';
part 'movie_detail_response.g.dart';

@freezed
sealed class MovieDetailResponse with _$MovieDetailResponse {
  const factory MovieDetailResponse({
    required Data data,
  }) = _MovieDetailResponse;

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) => _$MovieDetailResponseFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    required String id,
    required String title,
    required DateTime startDate,
    required DateTime? endDate,
    required String synopsis,
    required List<Image> images,
    required int? avgStar,
    required int? totalStar,
    required int maxEpisodes,
    required int numEpisodes,
    required int year,
    required String? season,
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
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
sealed class AgeRating with _$AgeRating {
  const factory AgeRating({
    required String id,
    required String? shortName,
    required String? longName,
    required String? description,
    required Image? image,
    required int minAgeToWatch,
  }) = _AgeRating;

  factory AgeRating.fromJson(Map<String, dynamic> json) => _$AgeRatingFromJson(json);
}

@freezed
sealed class Character with _$Character {
  const factory Character({
    required String id,
    required String name,
    required String? role,
    required Image image,
    required int status,
    required List<Producer> actors,
  }) = _Character;

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}

@freezed
sealed class Producer with _$Producer {
  const factory Producer({
    required String id,
    required String name,
    String? language,
    required Image? image,
    required int status,
    String? description,
  }) = _Producer;

  factory Producer.fromJson(Map<String, dynamic> json) => _$ProducerFromJson(json);
}