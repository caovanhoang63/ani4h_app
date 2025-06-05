import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.freezed.dart';

@freezed
sealed class HistoryModel with _$HistoryModel {
  const factory HistoryModel({
    required String id,
    required String title,
    required int episodeNumber,
    required String synopsis,
    required String imageUrl,
    required int viewCount,
    required int duration,
    required int watchedDuration,
  }) = _HistoryModel;
}