import '../dto/movies_response/movies_response.dart';

abstract interface class IHomeRepository {
  Future<MoviesResponse> getMovies(int page, int pageSize);
}