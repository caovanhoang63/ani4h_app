import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/dtos/genre.dart';
import '../../../../../common/dtos/image.dart';
import '../../../../../common/dtos/paging.dart';

part 'user_history_response.freezed.dart';
part 'user_history_response.g.dart';

@freezed
sealed class UserHistoryResponse with _$UserHistoryResponse {
  const factory UserHistoryResponse({
    required Data data,
  }) = _UserHistoryResponse;

  factory UserHistoryResponse.fromJson(Map<String, dynamic> json) => _$UserHistoryResponseFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    required List<Datum> data,
    required Paging paging,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
sealed class Datum with _$Datum {
  const factory Datum({
    required String id,
    required String title,
    required String synopsis,
    required String? synonyms,
    required String jaName,
    required String? enName,
    required List<Image> images,
    required List<Genre> genres,
    required int avgStar,
    required int totalStar,
    required int maxEpisodes,
    required int numEpisodes,
    required int year,
    required String? season,
    required String? state,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
