import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/features/history/domain/model/history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_state.freezed.dart';
@freezed
sealed class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<HistoryModel> histories,
    @Default(Paging(pageSize: 10, page: 1))Paging paging,
    @Default("3w5rMJ7r2JjRwM") String userId,
    @Default(false) bool isLoading,
    @Default(false) bool hasError,
    @Default(true) bool hasMore,
    @Default('') String errorMessage,
  }) = _HistoryState;
}