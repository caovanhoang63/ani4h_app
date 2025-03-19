import 'package:freezed_annotation/freezed_annotation.dart';

part 'users_response.freezed.dart';
part 'users_response.g.dart';

@freezed
sealed class UsersResponse with _$UsersResponse {
  const factory UsersResponse({
    required String? status,
    required List<Datum> data,
  }) = _UsersResponse;

  factory UsersResponse.fromJson(Map<String, dynamic> json) => _$UsersResponseFromJson(json);
}

@freezed
sealed class Datum with _$Datum {
  const factory Datum({
    required String id,
    required String? phoneNumber,
    required String firstName,
    required String lastName,
    required String displayName,
    required DateTime dateOfBirth,
    required String gender,
    required String role,
    required dynamic avatar,
    required int status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Datum;

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);
}
