import 'package:ani4h_app/features/movie_detail/data/dto/movie_response/movie_response.dart';

import '../dto/movies_response/movies_response.dart';

abstract interface class IMovieDetailRepository {
  Future<MovieResponse> getMovieDetail(String id);
  Future<MoviesResponse> getMovies(int page, int pageSize);
}