import 'package:ani4h_app/features/home/data/repository/ihome_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dto/movies_response/movies_response.dart';
import '../source/remote/home_api.dart';

final homeRepositoryProvider = Provider<IHomeRepository>((ref) {
  final homeApi = ref.watch(homeApiProvider);
  return HomeRepository(homeApi);
});

final class HomeRepository implements IHomeRepository {
  final HomeApi _homeApi;

  HomeRepository(this._homeApi);

  @override
  Future<MoviesResponse> getMovies(int page, int pageSize) async {
    try {
      final response = await _homeApi.getMovies(page, pageSize);
      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}