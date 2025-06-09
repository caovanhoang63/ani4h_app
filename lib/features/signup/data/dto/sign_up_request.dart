import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'sign_up_request.freezed.dart';
part 'sign_up_request.g.dart';

@freezed
sealed class SignUpRequest with _$SignUpRequest {
  const factory SignUpRequest({
    required String email,
    required String password,
     String? firstName,
     String? lastName,
     String? role,
     String? dateOfBirth,
  }) = _SignUpRequest;

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => _$SignUpRequestFromJson(json);
}
