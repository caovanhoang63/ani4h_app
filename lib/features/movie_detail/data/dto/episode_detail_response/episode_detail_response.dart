import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode_detail_response.freezed.dart';
part 'episode_detail_response.g.dart';

@freezed
sealed class EpisodeDetailResponse with _$EpisodeDetailResponse {
  const factory EpisodeDetailResponse({
    required Data data,
  }) = _EpisodeDetailResponse;

  factory EpisodeDetailResponse.fromJson(Map<String, dynamic> json) => 
      _$EpisodeDetailResponseFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
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
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}