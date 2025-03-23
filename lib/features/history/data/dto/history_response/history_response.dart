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
    required String name,
    required String national,
    required String imageUrl,
    required List<String> tags,
  }) = _History;

  factory History.fromJson(Map<String, dynamic> json) => _$HistoryFromJson(json);
}