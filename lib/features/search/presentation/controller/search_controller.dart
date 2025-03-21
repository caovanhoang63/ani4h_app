import 'package:ani4h_app/features/search/presentation/state/search_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchControllerProvider = AutoDisposeNotifierProvider<SearchController, SearchState>(SearchController.new);

class SearchController extends AutoDisposeNotifier<SearchState>{
  @override
  SearchState build() {
    return SearchState();
  }
}