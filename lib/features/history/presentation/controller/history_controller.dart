import 'package:ani4h_app/features/history/presentation/state/history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryController extends AutoDisposeNotifier<HistoryState> {
  @override
  HistoryState build() {
    return HistoryState();
  }
}