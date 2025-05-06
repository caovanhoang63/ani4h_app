import 'package:freezed_annotation/freezed_annotation.dart';

import '../movie_response/movie_response.dart';

part 'movies_response.freezed.dart';
part 'movies_response.g.dart';

@freezed
sealed class MoviesResponse with _$MoviesResponse {
  const factory MoviesResponse({
    required List<Datum> data,
  }) = _MoviesResponse;

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => _$MoviesResponseFromJson(json);
}

@freezed
sealed class Datum with _$Datum {
  const factory Datum({
    required String id,
    required String title,
    required String synopsis,
    required List<Image>? images,
    required dynamic avgStar,
    required dynamic totalStar,
    required int maxEpisodes,
    required int numEpisodes,
    required String ageRatingId,
    required int status,
    required State state,
    required dynamic ageRating,
    required dynamic seriesId,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
