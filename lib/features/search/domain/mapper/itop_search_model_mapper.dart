import 'package:ani4h_app/features/search/data/dto/top_search_response/top_search_response.dart';
import 'package:ani4h_app/features/search/domain/model/top_search_model.dart';

abstract class ITopSearchModelMapper {
  List<TopSearchModel> mapToTopSearchModel(TopSearchResponse response);
}