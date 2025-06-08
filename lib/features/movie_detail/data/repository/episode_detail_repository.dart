import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/episode_detail_response/episode_detail_response.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/episodes_response/episodes_response.dart';
import 'package:ani4h_app/features/movie_detail/data/repository/iepisode_detail_repository.dart';
import 'package:ani4h_app/features/movie_detail/data/source/remote/episode_detail_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final episodeDetailRepositoryProvider = Provider<IEpisodeDetailRepository>((ref) {
  final episodeDetailApi = ref.watch(episodeDetailApiProvider);
  return EpisodeDetailRepository(episodeDetailApi);
});

final class EpisodeDetailRepository with DioExceptionMapper implements IEpisodeDetailRepository {
  final EpisodeDetailApi _episodeDetailApi;

  EpisodeDetailRepository(this._episodeDetailApi);

  @override
  Future<EpisodeDetailResponse> getEpisodeDetail(String id) async {
    try {
      final response = await _episodeDetailApi.getEpisodeDetail(id);
      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: toException(e),
        stackTrace: s,
      );
    }
  }

  @override
  Future<EpisodesResponse> getListEpisodes(String filmId) {
    try {
      final response = _episodeDetailApi.getListEpisode(filmId);
      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: toException(e),
        stackTrace: s,
      );
    }
  }
}