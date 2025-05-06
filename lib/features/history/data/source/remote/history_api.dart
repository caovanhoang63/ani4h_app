import 'package:ani4h_app/core/data/remote/network_service.dart';
import 'package:ani4h_app/features/history/data/dto/history_response/history_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/error_logger.dart';
import 'package:ani4h_app/core/data/remote/endpoint.dart';

part 'history_api.g.dart';

final historyApiProvider = Provider<HistoryApi>((ref) {
  final dio = ref.watch(networkServiceProvider);
  return HistoryApi(dio);
});

@RestApi()
abstract class HistoryApi {
  factory HistoryApi(Dio dio) => _HistoryApi(dio);

  @GET(historyEndPoint)
  Future<HistoryResponse> getHistories(@Query("page") int page, @Query("pageSize") int pageSize);

  @POST(historyEndPoint)
  Future<void> addHistory(@Query("movieId") int movieId);

  @DELETE(historyEndPoint)
  Future<void> deleteHistory(@Query("movieId") int movieId);
}