import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode_detail_model.freezed.dart';

@freezed
sealed class EpisodeDetailModel with _$EpisodeDetailModel {
  const factory EpisodeDetailModel({
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
  }) = _EpisodeDetailModel;
}