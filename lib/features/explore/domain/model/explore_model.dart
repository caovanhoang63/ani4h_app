import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_model.freezed.dart';

@freezed
abstract class ExploreModel with _$ExploreModel {
  const factory ExploreModel({
    required String id,
    required String name,
    required String imageUrl,
  }) = _ExploreModel;
}