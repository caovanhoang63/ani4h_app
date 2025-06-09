import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_simple_response.freezed.dart';
part 'profile_simple_response.g.dart';

@freezed
sealed class ProfileSimpleResponse with _$ProfileSimpleResponse {
  const factory ProfileSimpleResponse({
    required String data,
  }) = _ProfileSimpleResponse;

  factory ProfileSimpleResponse.fromJson(Map<String, dynamic> json) => _$ProfileSimpleResponseFromJson(json);
}
