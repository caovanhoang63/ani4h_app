import 'package:freezed_annotation/freezed_annotation.dart';

part 'image.freezed.dart';
part 'image.g.dart';

@freezed
sealed class Image with _$Image {
  const factory Image({
    required String id,
    required String url,
    required int width,
    required int height,
    required String extension,
    required String cloudName,
  }) = _Image;

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);
}