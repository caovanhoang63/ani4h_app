import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/application/imovie_detail_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/movie_detail_response/movie_detail_response.dart';
import 'package:ani4h_app/features/movie_detail/domain/mapper/imovie_model_mapper.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/movie_detail_model.dart';
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
  Future<Result<MovieDetailModel, Failure>> getMovieDetail(String id) async {
    try {
      final response = await _movieDetailRepository.getMovieDetail(id);

      final model = mapToMovieDetailModel(response);

      return Result.success(model);
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
  MovieDetailModel mapToMovieDetailModel(MovieDetailResponse response) {
    final data = response.data;
    return MovieDetailModel(
      id: data.id,
      title: data.title,
      startDate: data.startDate,
      endDate: data.endDate,
      synopsis: data.synopsis,
      images: data.images, // Assuming images are already of type List<Image>
      avgStar: data.avgStar,
      totalStar: data.totalStar,
      maxEpisodes: data.maxEpisodes,
      numEpisodes: data.numEpisodes,
      year: data.year,
      season: data.season,
      averageEpisodeDuration: data.averageEpisodeDuration,
      ageRatingId: data.ageRatingId,
      status: data.status,
      state: data.state,
      ageRating: data.ageRating, // Assuming AgeRating is already correctly mapped or a simple DTO
      genres: data.genres, // Assuming genres are already of type List<Genre>
      characters: data.characters, // Assuming characters are already of type List<Character>
      producers: data.producers, // Assuming producers are already of type List<Producer>
      studios: data.studios, // Assuming studios are already of type List<Producer>
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      seriesId: data.seriesId,
      view: data.view,
    );
  }
}