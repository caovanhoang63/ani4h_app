import 'package:ani4h_app/features/main/presentation/state/main_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainControllerProvider = AutoDisposeNotifierProvider<MainController, MainState>(MainController.new);

class MainController extends AutoDisposeNotifier<MainState> {
  @override
  MainState build() {
    return MainState();
  }

  void selectTab(int index) {
    state = state.copyWith(currentTab: index);
  }
}