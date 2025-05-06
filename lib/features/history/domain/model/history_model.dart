import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.freezed.dart';

@freezed
sealed class HistoryModel with _$HistoryModel {
  const factory HistoryModel({
    required String id,
    required String name,
    required String national,
    required String imageUrl,
    required List<String> tags,
  }) = _HistoryModel;
}