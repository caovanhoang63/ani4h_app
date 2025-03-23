import 'package:ani4h_app/features/history/application/history_service.dart';
import 'package:ani4h_app/features/history/presentation/state/history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyControllerProvider = AutoDisposeNotifierProvider<HistoryController, HistoryState>(HistoryController.new);

class HistoryController extends AutoDisposeNotifier<HistoryState> {
  @override
  HistoryState build() {
    return HistoryState();
  }

  Future<void> fetchHistory(int page, int pageSize) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(historyServiceProvider).getHistories(page, pageSize);

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
}