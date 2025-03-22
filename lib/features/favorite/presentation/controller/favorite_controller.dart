import 'package:ani4h_app/common/http_status/status_code.dart';
import 'package:ani4h_app/features/favorite/application/favorite_service.dart';
import 'package:ani4h_app/features/favorite/presentation/state/favorite_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final favoriteControllerProvider = AutoDisposeNotifierProvider<FavoriteController, FavoriteState>(FavoriteController.new);

class FavoriteController extends AutoDisposeNotifier<FavoriteState> {
  @override
  FavoriteState build() {
    return FavoriteState();
  }

  Future<void> fetchFavorite(int page, int pageSize) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(favoriteServiceProvider).getFavorites(page, pageSize);

      result.when(
        (success) {
          state = state.copyWith(
            favorites: success,
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

  Future<void> removeFavorite(int id) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(favoriteServiceProvider).removeFavorite(id);

      result.when(
        (success) {
          state = state.copyWith(
            favorites: state.favorites.where((element) => element.id != id).toList(),
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