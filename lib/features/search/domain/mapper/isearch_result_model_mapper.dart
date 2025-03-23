import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';

abstract class ISearchResultModelMapper {
  List<SearchResultModel> mapToSearchResultModel(SearchResultResponse response);
}