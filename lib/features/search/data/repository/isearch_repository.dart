import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/data/dto/top_search_response/top_search_response.dart';

abstract interface class ISearchRepository {
  Future<SearchResultResponse> search(String query, int page, int pageSize);
  Future<TopSearchResponse> getTopSearch();
}