import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';

@freezed
sealed class MovieModel with _$MovieModel {
  const factory MovieModel({
    required String id,
    required String name,
    required String horizontalImage,
    required String verticalImage,
    required String type,
  }) = _MovieModel;
}