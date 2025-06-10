import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_add_request.freezed.dart';
part 'favorite_add_request.g.dart';

@freezed
sealed class FavoriteAddRequest with _$FavoriteAddRequest {
  const factory FavoriteAddRequest({
    required String userId,
    required String filmId,
  }) = _FavoriteAddRequest;

  factory FavoriteAddRequest.fromJson(Map<String, dynamic> json) => _$FavoriteAddRequestFromJson(json);
}
