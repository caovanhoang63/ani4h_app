import 'package:ani4h_app/features/movie_detail/data/dto/episode_detail_response/episode_detail_response.dart';

abstract interface class IEpisodeDetailRepository {
  Future<EpisodeDetailResponse> getEpisodeDetail(String id);
}