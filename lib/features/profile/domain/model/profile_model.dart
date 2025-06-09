import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/dtos/image.dart';

part 'profile_model.freezed.dart';
@freezed
sealed class ProfileModel with _$ProfileModel {
  const factory ProfileModel({
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
  }) = _ProfileModel;
}
