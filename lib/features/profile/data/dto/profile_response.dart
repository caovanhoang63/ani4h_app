
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import '../../../../common/dtos/image.dart';

part 'profile_response.freezed.dart';
part 'profile_response.g.dart';

@freezed
sealed class ProfileResponse with _$ProfileResponse {
  const factory ProfileResponse({
    required Data data,
  }) = _ProfileResponse;

  factory ProfileResponse.fromJson(Map<String, dynamic> json) => _$ProfileResponseFromJson(json);
}

@freezed
sealed class Data with _$Data {
  const factory Data({
    required String id,
    required String? phoneNumber,
    required String? firstName,
    required String? lastName,
    required String? displayName,
    required DateTime? dateOfBirth,
    required String? gender,
    required String? role,
    required Image? avatar,
    required int status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}
