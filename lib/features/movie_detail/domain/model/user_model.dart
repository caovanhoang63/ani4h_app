import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
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
  }) = _UserModel;
}