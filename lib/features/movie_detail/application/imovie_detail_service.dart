import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_detail_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IMovieDetailService {
  Future<Result<MovieDetailModel, Failure>> getMovieDetail(String id);
  Future<Result<bool, Failure>> getIsFavorite(String userId, String movieId);
}