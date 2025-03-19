import 'dart:developer';

import 'package:ani4h_app/core/provider/auth_state_provider.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/login_request/login_request.dart';
import 'package:ani4h_app/features/movie_detail/presentation/state/movie_detail_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/movie_detail_service.dart';

final movieDetailControllerProvider = AutoDisposeNotifierProvider<MovieDetailController, MovieDetailState>(MovieDetailController.new);

class MovieDetailController extends AutoDisposeNotifier<MovieDetailState> {
  @override
  MovieDetailState build() {
    return MovieDetailState();
  }

  Future<void> fetchUser(int page, int pageSize) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(movieDetailServiceProvider).getUsers(page, pageSize);

      result.when(
        (success) {
          state = state.copyWith(
            users: success,
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

  Future<void> login(String email, String password) async {
    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final request = LoginRequest(email: email, password: password);

      final result = await ref.read(movieDetailServiceProvider).login(request);

      result.when(
        (success) {
          ref.invalidate(authStateProvider);
          ref.read(authStateProvider.notifier).setAuthState(success);

          state = state.copyWith(
            isLoading: false,
            hasError: false,
            isLoginSuccess: true,
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