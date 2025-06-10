import 'package:freezed_annotation/freezed_annotation.dart';

part 'upsert_request.freezed.dart';
part 'upsert_request.g.dart';

@freezed
sealed class UpsertRequest with _$UpsertRequest {
  const factory UpsertRequest({
    required String userId,
    required String episodeId,
    required int watchedDuration,
  }) = _UpsertRequest;

  factory UpsertRequest.fromJson(Map<String, dynamic> json) => _$UpsertRequestFromJson(json);
}
