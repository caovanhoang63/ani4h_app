import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:ani4h_app/features/search/domain/model/top_search_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class ISearchService {
  Future<Result<List<SearchResultModel>, Failure>> search(String query, int page, int pageSize);
  Future<Result<List<TopSearchModel>, Failure>> getTopSearch();
}