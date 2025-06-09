import 'dart:developer';

import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/provider/current_movie_state/current_movie_state.dart';
import 'package:ani4h_app/core/data/local/secure_storage/secure_storage.dart';
import 'package:ani4h_app/features/movie_detail/application/episode_detail_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/favorite_add_request/favorite_add_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/movie_detail/application/movie_detail_service.dart';
import '../../../features/search/application/search_service.dart';


final currentMovieControllerProvider = NotifierProvider<CurrentMovieController, CurrentMovieState>(CurrentMovieController.new);

class CurrentMovieController extends Notifier<CurrentMovieState> {
  @override
  CurrentMovieState build() {
    return CurrentMovieState();
  }

  void clearCurrentMovie() {
    state = state.copyWith(movieDetail: null);
  }

  Future<void> fetchCurrentMovie(String id) async {
    final userId = await ref.read(secureStorageProvider).read("userIdState");

    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
      );

      final result = await ref.read(movieDetailServiceProvider).getMovieDetail(id);
      result.when(
        (success) async {
          state = state.copyWith(
            movieDetail: success,
            isLoading: false,
            hasError: false,
          );
          if (userId != null) {
            final isFavoriteRes = await ref.read(movieDetailServiceProvider).getIsFavorite(userId, success.id);
            isFavoriteRes.when(
              (isFavorite) {
                state = state.copyWith(
                  isFavorite: isFavorite,
                );
              },
              (failure) {
                state = state.copyWith(
                  hasError: true,
                  errorMessage: failure.message,
                );
              },
            );
          }

          final similarMoviesRes = await ref.read(searchServiceProvider).getContentBasedSuggestion(success.id, 1, Paging(page: 1, pageSize: 10));
          similarMoviesRes.when(
            (similarMovies) {
              state = state.copyWith(
                similarMovies: similarMovies.data,
              );
            },
            (failure) {
              state = state.copyWith(
                hasError: true,
                errorMessage: failure.message,
              );
            },
          );

          final episodesRes =  await ref.read(episodeDetailServiceProvider).getListEpisodes(success.id);
          episodesRes.when(
            (episodes) {
              state = state.copyWith(
                episodes: episodes,
              );
            },
            (failure) {
              state = state.copyWith(
                hasError: true,
                errorMessage: failure.message,
              );
            },
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
        errorMessage: e.toString()
      );
    }
  }

  Future<void> addFavorite(String filmId) async {
    final userId = await ref.read(secureStorageProvider).read("userIdState");
    if (userId == null) {
      log("User ID is null, cannot add favorite.");
      return;
    }

    final req = FavoriteAddRequest(
      userId: userId,
      filmId: filmId,
    );
    print("Adding favorite for userId: $userId, filmId: $filmId");

    final result = await ref.read(movieDetailServiceProvider).addToFavorite(req);
    result.when(
      (success) {
        state = state.copyWith(isFavorite: true);
        log("Favorite added successfully for userId: $userId, filmId: $filmId");
      },
      (failure) {
        print("Failed to add favorite: ${failure.message}");
        state = state.copyWith(
          hasError: true,
          errorMessage: failure.message,
        );
      },
    );
  }

  Future<void> removeFavorite(String filmId) async {
    final userId = await ref.read(secureStorageProvider).read("userIdState");
    if (userId == null) {
      log("User ID is null, cannot remove favorite.");
      return;
    }

    final result = await ref.read(movieDetailServiceProvider).removeFromFavorite(userId, filmId);
    result.when(
      (success) {
        state = state.copyWith(isFavorite: false);
      },
      (failure) {
        state = state.copyWith(
          hasError: true,
          errorMessage: failure.message,
        );
      },
    );
  }
}