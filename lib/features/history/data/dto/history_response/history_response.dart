import 'package:ani4h_app/common/dtos/image.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_response.freezed.dart';
part 'history_response.g.dart';

@freezed
sealed class HistoryResponse with _$HistoryResponse {
  const factory HistoryResponse({
    required List<History> data,
  }) = _HistoryResponse;

  factory HistoryResponse.fromJson(Map<String, dynamic> json) => _$HistoryResponseFromJson(json);
}

@freezed
sealed class History with _$History {
  const factory History({
    required String id,
    required String title,
    required int episodeNumber,
    required String synopsis,
    required Image thumbnail,
    required int viewCount,
    required int duration,
    required int watchedDuration,
    required String filmId,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
}