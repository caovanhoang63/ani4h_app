import '../domain/model/movie_model.dart';

abstract interface class IHomeService {
  Future<List<MovieModel>> getMovies(int page, int pageSize);
}