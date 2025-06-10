import 'package:ani4h_app/common/dtos/paging.dart';
import 'package:ani4h_app/common/exception/failure.dart';
import 'package:ani4h_app/features/history/application/ihistory_service.dart';
import 'package:ani4h_app/features/history/data/dto/history_response/history_response.dart';
import 'package:ani4h_app/features/history/data/repository/history_repository.dart';
import 'package:ani4h_app/features/history/data/repository/ihistory_repository.dart';
import 'package:ani4h_app/features/history/domain/mapper/ihistory_model_mapper.dart';
import 'package:ani4h_app/features/history/domain/model/history_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

final historyServiceProvider = Provider<IHistoryService>((ref) {
  final historyRepository = ref.watch(historyRepositoryProvider);
  return HistoryService(historyRepository);
});

final class HistoryService implements IHistoryService, IHistoryModelMapper {
  final IHistoryRepository _historyRepository;

  HistoryService(this._historyRepository);

  @override
  Future<Result<List<HistoryModel>, Failure>> getHistories(String userId, Paging paging) async {
    try{
      final response = await _historyRepository.getHistories(userId, paging);
      final models = mapToHistoryModel(response);
      return Result.success(models);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }
  @override
  Future<Result<bool, Failure>> addHistory(int movieId) async {
    try{
      await _historyRepository.addHistory(movieId);
      return const Result.success(true);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }
  @override
  Future<Result<bool, Failure>> deleteHistory(int movieId) async {
    try{
      await _historyRepository.deleteHistory(movieId);
      return const Result.success(true);
    } on Failure catch (e) {
      return Error(e);
    } catch (e, s) {
      return Error(
        Failure(
          message: "An unexpected error occurred, ${e.toString()}",
          exception: e as Exception,
          stackTrace: s,
        ),
      );
    }
  }

  @override
  List<HistoryModel> mapToHistoryModel(HistoryResponse response) {
    return response.data.map((e) => HistoryModel(
        id: e.id,
        title: e.title,
        episodeNumber: e.episodeNumber,
        synopsis: e.synopsis,
        imageUrl: e.thumbnail.url,
        viewCount: e.viewCount,
        duration: e.duration,
        watchedDuration: e.watchedDuration,
        filmId: e.filmId,
      )
    ).toList();
  }
}