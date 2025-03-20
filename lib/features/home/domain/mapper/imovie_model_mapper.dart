import 'package:ani4h_app/features/home/data/dto/movies_response/movies_response.dart';
import '../model/movie_model.dart';

abstract class IMovieModelMapper {
  List<MovieModel> mapToMovieModel(MoviesResponse response);
}