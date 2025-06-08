import 'package:ani4h_app/core/data/remote/endpoint.dart';
import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/episode_detail_response/episode_detail_response.dart';
import 'package:ani4h_app/features/movie_detail/data/dto/episodes_response/episodes_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'episode_detail_api.g.dart';

final episodeDetailApiProvider = Provider<EpisodeDetailApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return EpisodeDetailApi(dio);
});

@RestApi()
abstract class EpisodeDetailApi {
  factory EpisodeDetailApi(Dio dio) => _EpisodeDetailApi(dio);

  @GET("$episodeEndPoint/{id}")
  Future<EpisodeDetailResponse> getEpisodeDetail(@Path("id") String id);

  @GET("$filmEndPoint/{filmId}/episodes")
  Future<EpisodesResponse> getListEpisode(@Path("filmId") String filmId);
}