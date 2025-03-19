import 'package:ani4h_app/features/home/application/ihome_service.dart';
import 'package:ani4h_app/features/home/data/dto/movies_response/movies_response.dart';
import 'package:ani4h_app/features/home/domain/mapper/imovie_model_mapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  Future<List<MovieModel>> getMovies(int page, int pageSize) async {
    try {
      final response = await _homeRepository.getMovies(page, pageSize);

      final models = mapToMovieModel(response);

      return models;
    } catch (e) {
      rethrow;
    }
  }

  @override
  List<MovieModel> mapToMovieModel(MoviesResponse response) {
    return response.data.map((e) => MovieModel(
      id: e.id,
      name: e.name,
      horizontalImage: e.horizontalImage,
      verticalImage: e.verticalImage,
      type: e.type,
    )).toList();
  }
}