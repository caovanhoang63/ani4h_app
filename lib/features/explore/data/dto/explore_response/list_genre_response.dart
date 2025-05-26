import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_genre_response.freezed.dart';
part 'list_genre_response.g.dart';

@freezed
abstract class ListGenreResponse with _$ListGenreResponse {
  const factory ListGenreResponse({
    required List<Genre> data,
  }) = _ListGenreResponse;

  factory ListGenreResponse.fromJson(Map<String, dynamic> json) => _$ListGenreResponseFromJson(json);
}
