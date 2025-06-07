import 'package:ani4h_app/features/movie_detail/data/dto/episode_detail_response/episode_detail_response.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/episode_detail_model.dart';

abstract class IEpisodeModelMapper {
  EpisodeDetailModel mapToEpisodeDetailModel(EpisodeDetailResponse response);
}