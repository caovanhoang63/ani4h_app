import 'package:ani4h_app/features/movie_detail/data/dto/movies_response/movies_response.dart';

import '../../data/dto/movie_response/movie_response.dart';
import '../model/movie_model.dart';

abstract class IMovieModelMapper {
  MovieModel mapToMovieModel(MovieResponse response);
  List<MovieModel> mapToListMovieModel(MoviesResponse response);
}