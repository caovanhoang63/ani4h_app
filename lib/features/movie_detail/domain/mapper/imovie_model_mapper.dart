import '../../data/dto/movie_response/movie_response.dart';
import '../model/movie_model.dart';

abstract class IMovieModelMapper {
  MovieModel mapToMovieModel(MovieResponse response);
}