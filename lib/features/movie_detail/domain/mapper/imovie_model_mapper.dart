import 'package:ani4h_app/features/movie_detail/data/dto/is_favorite_response/is_favorite_response.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_detail_model.dart';

abstract class IMovieModelMapper {
  MovieDetailModel mapToMovieDetailModel(MovieDetailResponse response);
  bool mapToIsFavoriteModel(IsFavoriteResponse response);
}