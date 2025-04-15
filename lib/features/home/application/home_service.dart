import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/home/application/ihome_service.dart';
import 'package:ani4h_app/features/home/data/dto/movies_response/movies_response.dart';
import 'package:ani4h_app/features/home/domain/mapper/imovie_model_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import '../data/repository/home_repository.dart';
import '../data/repository/ihome_repository.dart';
import '../domain/model/movie_model.dart';

final homeServiceProvider = Provider<IHomeService>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return HomeService(homeRepository);
});

final class HomeService implements IHomeService, IMovieModelMapper {
  final IHomeRepository _homeRepository;

  HomeService(this._homeRepository);

  @override
  Future<Result<List<MovieModel>, Failure>> getMovies(int page, int pageSize) async {
    try {
      final response = await _homeRepository.getMovies(page, pageSize);

      final models = mapToMovieModel(response);

      return Result.success(models);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: toException(e),
          stackTrace: s,
        ),
      );
    }
  }

  @override
  List<MovieModel> mapToMovieModel(MoviesResponse response) {
    return response.data.map((e) => MovieModel(
      id: e.id,
      title: e.title,
      images: e.images,
      state: e.state,
    )).toList();
  }
}