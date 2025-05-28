import 'package:ani4h_app/features/explore/data/dto/explore_response/explore_response.dart';
import 'package:ani4h_app/features/explore/domain/model/explore_model.dart';

abstract class IExploreModelMapper {
  ExploreModel mapToExploreModel(ExploreResponse exploreRequestDto);
}