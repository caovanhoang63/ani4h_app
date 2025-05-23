import 'package:ani4h_app/common/exception/failure.dart';
import 'package:multiple_result/multiple_result.dart';
import '../domain/model/movie_model.dart';

abstract interface class IHomeService {
  Future<Result<List<MovieModel>, Failure>> getMovies(int page, int pageSize);
}