import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/history/domain/model/history_model.dart';
import 'package:multiple_result/multiple_result.dart';

abstract interface class IHistoryService {
  Future<Result<List<HistoryModel>, Failure>> getHistories(String userId, Paging paging);
  Future<Result<bool, Failure>> addHistory(int movieId);
  Future<Result<bool, Failure>> deleteHistory(int movieId);
}