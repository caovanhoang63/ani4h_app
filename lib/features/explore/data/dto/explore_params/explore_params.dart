import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_params.freezed.dart';
part 'explore_params.g.dart';

@freezed
abstract class ExploreParams with _$ExploreParams {
  const factory ExploreParams({
    required String? genreId,
    required int? year,
    required String? season,
  }) = _ExploreParams;

  factory ExploreParams.fromJson(Map<String, dynamic> json) => _$ExploreParamsFromJson(json);
}