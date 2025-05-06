import 'package:ani4h_app/features/home/data/dto/movies_response/movies_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_model.freezed.dart';

@freezed
sealed class MovieModel with _$MovieModel {
  const factory MovieModel({
    required String id,
    required String title,
    required List<Image>? images,
    required State state,
  }) = _MovieModel;
}