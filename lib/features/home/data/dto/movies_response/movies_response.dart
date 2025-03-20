import 'package:freezed_annotation/freezed_annotation.dart';

part 'movies_response.freezed.dart';
part 'movies_response.g.dart';

@freezed
sealed class MoviesResponse with _$MoviesResponse {

  const factory MoviesResponse({
    required String status,
    required List<Datum> data,
  }) = _MoviesResponse;

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => _$MoviesResponseFromJson(json);
}

@freezed
sealed class Datum with _$Datum {
  const factory Datum({
    required String id,
    required String name,
    required String horizontalImage,
    required String verticalImage,
    required String type,
    required int status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
