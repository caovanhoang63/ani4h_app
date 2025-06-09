import 'package:ani4h_app/features/movie_detail/data/dto/favorite_add_request/favorite_add_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';

abstract interface class IMovieDetailRepository {
  Future<MovieDetailResponse> getMovieDetail(String id);
  Future<bool> getIsFavorite(String userId, String filmId);
  Future<void> addToFavorite(FavoriteAddRequest request);
  Future<void> removeFromFavorite(String userId, String filmId);
}