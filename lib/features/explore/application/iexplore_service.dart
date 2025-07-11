import 'package:ani4h_app/common/dtos/genre.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/domain/model/explore_model.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IExploreService {
  Future<Result<ExploreModel, Failure>> getExplore(ExploreParams filter, PagingSearch paging);
  Future<Result<List<Genre>, Failure>> getGenres();
}