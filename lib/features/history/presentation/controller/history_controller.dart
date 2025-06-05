import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/features/history/application/history_service.dart';
import 'package:ani4h_app/features/history/presentation/state/history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyControllerProvider = AutoDisposeNotifierProvider<HistoryController, HistoryState>(HistoryController.new);

class HistoryController extends AutoDisposeNotifier<HistoryState> {
  @override
  HistoryState build() {
    return HistoryState();
  }

  Future<void> fetchHistory() async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(historyServiceProvider).getHistories(state.userId, state.paging);

      result.when(
        (success) {
          state = state.copyWith(
            histories: success,
            isLoading: false,
            hasError: false,
          );
        },
        (failure) {
          state = state.copyWith(
            isLoading: false,
            hasError: true,
            errorMessage: failure.message,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> fetchMoreHistory() async {
    if(state.hasMore == false) return;

    try {
      state = state.copyWith(
        hasError: false,
      );
      state = state.copyWith(
        paging: Paging(
          pageSize: state.paging.pageSize,
          page: state.paging.page + 1,
        ),
      );

      final result = await ref.read(historyServiceProvider).getHistories(state.userId, state.paging);

      result.when(
        (success) {
          state = state.copyWith(
            histories: [...state.histories, ...success],
            hasError: false,
          );
          if(success.isEmpty) {
            state = state.copyWith(
              hasMore: false,
            );
          }
        },
        (failure) {
          state = state.copyWith(
            hasError: true,
            errorMessage: failure.message,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        hasError: true,
        errorMessage: e.toString(),
      );
    }
  }
}