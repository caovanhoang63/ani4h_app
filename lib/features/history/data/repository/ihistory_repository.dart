import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/features/history/data/dto/history_response/history_response.dart';

abstract interface class IHistoryRepository {
  Future<HistoryResponse> getHistories(String userId, Paging paging);
  Future<void> addHistory(int movieId);
  Future<void> deleteHistory(int movieId);
}