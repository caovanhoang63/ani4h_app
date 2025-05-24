import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_hot_response/top_hot_response.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';

abstract class ISearchResultModelMapper {
  SearchResultModel mapToSearchResultModel(SearchResultResponse response);
  SearchResultModel mapToSearchResultModelFromTopHotResponse(
      TopHotResponse response);
}