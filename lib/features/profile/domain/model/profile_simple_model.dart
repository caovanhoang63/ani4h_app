import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_simple_model.freezed.dart';

@freezed
sealed class ProfileSimpleModel with _$ProfileSimpleModel {
  const factory ProfileSimpleModel({
    required String userId,
  }) = _ProfileSimpleModel;
}

