import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/domain/model/explore_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IExploreService {
  Future<Result<List<ExploreModel>, Failure>> getExplore(ExploreParams params, int page, int pageSize);
}