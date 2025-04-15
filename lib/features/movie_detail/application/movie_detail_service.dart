import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/application/imovie_detail_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/movie_response/movie_response.dart';
import 'package:ani4h_app/features/movie_detail/domain/mapper/imovie_model_mapper.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import '../data/repository/imovie_detail_repository.dart';
import '../data/repository/movie_detail_repository.dart';

final movieDetailServiceProvider = Provider<IMovieDetailService>((ref) {
  final movieDetailRepository = ref.watch(movieDetailRepositoryProvider);
  return MovieDetailService(movieDetailRepository);
});

final class MovieDetailService implements IMovieDetailService, IMovieModelMapper {
  final IMovieDetailRepository _movieDetailRepository;

  MovieDetailService(this._movieDetailRepository);

  @override
  Future<Result<MovieModel, Failure>> getMovieDetail(String id) async {
    try {
      final response = await _movieDetailRepository.getMovieDetail(id);

      final model = mapToMovieModel(response);

      return Result.success(model);
    } on Failure catch (e) {
      print("Failure: ${e.message}");
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
  MovieModel mapToMovieModel(MovieResponse response) {
    return MovieModel(
      id: response.data.id,
      title: response.data.title,
      startDate: response.data.startDate,
      endDate: response.data.endDate,
      synopsis: response.data.synopsis,
      images: response.data.images,
      avgStar: response.data.avgStar,
      totalStar: response.data.totalStar,
      maxEpisodes: response.data.maxEpisodes,
      numEpisodes: response.data.numEpisodes,
      year: response.data.year,
      season: response.data.season,
      averageEpisodeDuration: response.data.averageEpisodeDuration,
      ageRatingId: response.data.ageRatingId,
      status: response.data.status,
      state: response.data.state,
      ageRating: response.data.ageRating,
      genres: response.data.genres,
      createdAt: response.data.createdAt,
      updatedAt: response.data.updatedAt,
      seriesId: response.data.seriesId,
    );
  }
}