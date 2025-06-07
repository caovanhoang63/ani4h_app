import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
sealed class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required LoginData data,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
}

@freezed
sealed class LoginData with _$LoginData {
  const factory LoginData({
    required String email,
    required String accessToken,
    required String refreshToken,
  }) = _LoginData;

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
}