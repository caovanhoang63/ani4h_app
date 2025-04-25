import 'package:ani4h_app/features/history/domain/model/history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_state.freezed.dart';
@freezed
sealed class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<HistoryModel> histories,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default('') String errorMessage,
  }) = _HistoryState;
}