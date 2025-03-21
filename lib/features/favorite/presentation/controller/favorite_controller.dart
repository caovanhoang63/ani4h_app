import 'package:ani4h_app/features/favorite/presentation/state/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteControllerProvider = AutoDisposeNotifierProvider<FavoriteController, FavoriteState>(FavoriteController.new);

class FavoriteController extends AutoDisposeNotifier<FavoriteState> {
  @override
  FavoriteState build() {
    return FavoriteState();
  }
}