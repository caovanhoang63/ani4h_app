import 'package:ani4h_app/features/explore/data/dto/explore_params/explore_params.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/explore_response.dart';
import 'package:ani4h_app/features/explore/data/dto/explore_response/list_genre_response.dart';
import 'package:ani4h_app/features/search/data/dto/search_result_response/search_result_response.dart';

abstract interface class IExploreRepository {
  Future<ExploreResponse> getExplore(ExploreParams filter, PagingSearch paging);
  Future<ListGenreResponse> getGenres();
}