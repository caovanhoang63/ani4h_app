import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_hot_response/top_hot_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_favorite_response/user_favorite_response.dart';
import 'package:ani4h_app/features/search/data/dto/user_history_response/user_history_response.dart';

abstract interface class ISearchRepository {
  Future<SearchResultResponse> search(SearchRequest request, PagingSearch paging);
  Future<TopHotResponse> getTopHot(Paging paging);
  Future<UserFavoriteResponse> getUserFavorites(
    String? userId,
    int seed,
    Paging paging,
  );
  Future<UserHistoryResponse> getUserHistorySuggestion(String? userId, int seed, Paging paging);
}