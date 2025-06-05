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

extension ExploreParamsExtension on ExploreParams {
  Map<String, dynamic> toCleanJson() {
    final json = <String, dynamic>{
      'genreId': genreId,
      'year': year,
      'season': season,
    };

    json.removeWhere((key, value) => value == null || (value is String && value.trim().isEmpty));

    return json;
  }
}
