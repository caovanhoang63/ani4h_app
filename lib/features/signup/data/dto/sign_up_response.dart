import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'sign_up_response.freezed.dart';
part 'sign_up_response.g.dart';

@freezed
sealed class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse({
    required String data,
  }) = _SignUpResponse;

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => _$SignUpResponseFromJson(json);
}
