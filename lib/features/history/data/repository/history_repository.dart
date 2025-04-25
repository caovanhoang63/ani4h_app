import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/common/mixin/dio_exception_mapper.dart';
import 'package:ani4h_app/features/history/data/dto/history_response/history_response.dart';
import 'package:ani4h_app/features/history/data/repository/ihistory_repository.dart';
import 'package:ani4h_app/features/history/data/source/remote/history_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyRepositoryProvider = Provider<IHistoryRepository>((ref) {
  final historyApi = ref.watch(historyApiProvider);
  return HistoryRepository(historyApi);
});

final class HistoryRepository with DioExpceptionMapper implements IHistoryRepository {
  final HistoryApi _historyApi;

  HistoryRepository(this._historyApi);

  @override
  Future<HistoryResponse> getHistories(int page, int pageSize) async {
    try {
      final response = await _historyApi.getHistories(page, pageSize);
      return response;
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: e as Exception,
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> addHistory(int movieId) async {
    try {
      await _historyApi.addHistory(movieId);
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: e as Exception,
        stackTrace: s,
      );
    }
  }

  @override
  Future<void> deleteHistory(int movieId) async {
    try {
      await _historyApi.deleteHistory(movieId);
    } on DioException catch (e, s) {
      throw mapDioExceptionToFailure(e, s);
    } catch (e, s) {
      throw Failure(
        message: "An unexpected error occurred",
        exception: e as Exception,
        stackTrace: s,
      );
    }
  }
}