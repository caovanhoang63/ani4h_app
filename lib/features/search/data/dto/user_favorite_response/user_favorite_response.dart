import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../common/dtos/image.dart';

part 'user_favorite_response.freezed.dart';
part 'user_favorite_response.g.dart';

@freezed
sealed class UserFavoriteResponse with _$UserFavoriteResponse {
  const factory UserFavoriteResponse({
    required Data data,
  }) = _UserFavoriteResponse;

  factory UserFavoriteResponse.fromJson(Map<String, dynamic> json) => _$UserFavoriteResponseFromJson(json);
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
