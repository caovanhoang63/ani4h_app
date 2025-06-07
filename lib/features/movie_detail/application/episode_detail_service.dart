import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/application/iepisode_detail_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/episode_detail_response/episode_detail_response.dart';
import 'package:ani4h_app/features/movie_detail/data/repository/episode_detail_repository.dart';
import 'package:ani4h_app/features/movie_detail/data/repository/iepisode_detail_repository.dart';
import 'package:ani4h_app/features/movie_detail/domain/mapper/iepisode_model_mapper.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/episode_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

final episodeDetailServiceProvider = Provider<IEpisodeDetailService>((ref) {
  final episodeDetailRepository = ref.watch(episodeDetailRepositoryProvider);
  return EpisodeDetailService(episodeDetailRepository);
});

final class EpisodeDetailService implements IEpisodeDetailService, IEpisodeModelMapper {
  final IEpisodeDetailRepository _episodeDetailRepository;

  EpisodeDetailService(this._episodeDetailRepository);

  @override
  Future<Result<EpisodeDetailModel, Failure>> getEpisodeDetail(String id) async {
    try {
      final response = await _episodeDetailRepository.getEpisodeDetail(id);

      final model = mapToEpisodeDetailModel(response);

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
  EpisodeDetailModel mapToEpisodeDetailModel(EpisodeDetailResponse response) {
    final data = response.data;
    return EpisodeDetailModel(
      id: data.id,
      title: data.title,
      episodeNumber: data.episodeNumber,
      synopsis: data.synopsis,
      duration: data.duration,
      thumbnail: data.thumbnail,
      videoUrl: data.videoUrl,
      viewCount: data.viewCount,
      airDate: data.airDate,
      state: data.state,
      status: data.status,
      createdAt: data.createdAt,
      updatedAt: data.updatedAt,
      filmId: data.filmId,
      watchedDuration: data.watchedDuration,
    );
  }

  @override
  List<EpisodeDetailModel> mapToEpisodeDetailModels(response) {
    return response.data.map((e) => EpisodeDetailModel(
        id: e.id,
        title: e.title,
        episodeNumber: e.episodeNumber,
        synopsis: e.synopsis,
        duration: e.duration,
        thumbnail: e.thumbnail,
        videoUrl: e.videoUrl,
        viewCount: e.viewCount,
        airDate: e.airDate,
        state: e.state,
        status: e.status,
        createdAt: e.createdAt,
        updatedAt: e.updatedAt,
        filmId: e.filmId,
        watchedDuration: e.watchedDuration,
    )).toList();
  }
}