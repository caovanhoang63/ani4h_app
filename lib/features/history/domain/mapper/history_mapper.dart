import 'package:ani4h_app/features/history/data/dto/history_response/history_response.dart';
import 'package:ani4h_app/features/history/domain/model/history_model.dart';

abstract class IHistoryMapper {
  List<HistoryModel> mapToHistoryModel(HistoryResponse response);
}