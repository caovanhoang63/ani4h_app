import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/explore_response.dart';

abstract interface class IExploreRepository {
  Future<ExploreResponse> getExplore(ExploreParams params, int page, int pageSize);
}