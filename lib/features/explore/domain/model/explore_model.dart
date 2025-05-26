import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_model.freezed.dart';

@freezed
abstract class ExploreModel with _$ExploreModel {
  const factory ExploreModel({
    required String id,
    required String title,
    required String imageUrl,
  }) = _ExploreModel;
}