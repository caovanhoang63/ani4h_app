import 'package:freezed_annotation/freezed_annotation.dart';

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

enum State {
  finished,
  on_air,
  upcoming
}

final stateValues = EnumValues({
  "finished": State.finished,
  "on_air": State.on_air,
  "upcoming": State.upcoming
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
