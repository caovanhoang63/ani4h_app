import 'package:freezed_annotation/freezed_annotation.dart';

part 'is_favorite_response.freezed.dart';
part 'is_favorite_response.g.dart';

@freezed
sealed class IsFavoriteResponse with _$IsFavoriteResponse {
  const factory IsFavoriteResponse({
    required bool data,
  }) = _IsFavoriteResponse;

  factory IsFavoriteResponse.fromJson(Map<String, dynamic> json) => _$IsFavoriteResponseFromJson(json);
}
