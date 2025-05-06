import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/search/data/dto/search_request/search_request.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';
import 'package:ani4h_app/features/search/domain/model/search_result_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class ISearchService {
  Future<Result<SearchResultModel, Failure>> search(SearchRequest request, PagingSearch pageCur);
}