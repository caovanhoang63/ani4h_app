import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';

abstract interface class IMovieDetailRepository {
  Future<MovieDetailResponse> getMovieDetail(String id);
}