import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/favorite_add_request/favorite_add_request.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/is_favorite_response/is_favorite_response.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_detail_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IMovieDetailService {
  Future<Result<MovieDetailModel, Failure>> getMovieDetail(String id);
  Future<Result<bool, Failure>> getIsFavorite(String userId, String movieId);
  Future<Result<void, Failure>> addToFavorite(FavoriteAddRequest request);
  Future<Result<void, Failure>> removeFromFavorite(String userId, String movieId);
}