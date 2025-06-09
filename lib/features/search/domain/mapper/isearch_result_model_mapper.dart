import 'package:ani4h_app/features/search/data/dto/content_based_response/content_based_response.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_hot_response/top_hot_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_favorite_response/user_favorite_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_history_response/user_history_response.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';

abstract class ISearchResultModelMapper {
  SearchResultModel mapToSearchResultModel(SearchResultResponse response);
  SearchResultModel mapToSearchResultModelFromTopHotResponse(
      TopHotResponse response);
  SearchResultModel mapToSearchResultModelFromUserFavoriteResponse(
      UserFavoriteResponse response);
  SearchResultModel mapToSearchResultModelFromUserHistoryResponse(
      UserHistoryResponse response);
  SearchResultModel mapToSearchResultModelFromContentBasedResponse(
      ContentBasedResponse response);
}