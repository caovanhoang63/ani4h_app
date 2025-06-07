import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/movie_detail/domain/model/episode_detail_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IEpisodeDetailService {
  Future<Result<EpisodeDetailModel, Failure>> getEpisodeDetail(String id);
}