import 'package:freezed_annotation/freezed_annotation.dart';

part 'episodes_response.freezed.dart';
part 'episodes_response.g.dart';

@freezed
sealed class EpisodesResponse with _$EpisodesResponse {
  const factory EpisodesResponse({
    required List<Datum> data,
  }) = _EpisodesResponse;

  factory EpisodesResponse.fromJson(Map<String, dynamic> json) => _$EpisodesResponseFromJson(json);
}

@freezed
sealed  class Datum with _$Datum {
  const factory Datum({
    required String id,
    required String title,
    required int episodeNumber,
    required String synopsis,
    required int duration,
    String? thumbnail,
    required String videoUrl,
    required int viewCount,
    DateTime? airDate,
    required String state,
    required int status,
    required DateTime createdAt,
    required DateTime updatedAt,
    required String filmId,
    int? watchedDuration,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
